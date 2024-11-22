import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/core/service/messages.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/view/auth/signup/controller/signup_controller.dart';
import 'package:chess_league/widgets/buttons/custom_elevated_button.dart';
import 'package:chess_league/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final GlobalKey<FormState> _thisKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await Messages.onWillPop(
          'Leave Chess League',
          'Are You Sure you want to leave?',
        );
        return shouldExit;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: GetBuilder<SignupController>(
            init: SignupController(),
            builder: (controller) => Form(
              key: _thisKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
                    ClipOval(
                      child: Container(
                        color:
                            Colors.transparent, // Background color, if needed
                        child: SvgPicture.asset(
                          AppImages.chessLanding2,
                          width: 50.w, // Adjust to fit the desired size
                          height: 25.h, // Adjust to fit the desired size
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Create Your Account And Start Playing!",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: ColorsManager.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Username Field
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomTextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (_) => () {},
                        suffixIcon: null,
                        containerWidth: 90.w,
                        hintText: "First Name",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black54,
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: controller.nameValidator,
                        onSaved: (value) => controller.setUserName(value ?? ''),
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Email Field
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomTextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (_) => () {},
                        suffixIcon: null,
                        containerWidth: 90.w,
                        hintText: "Email Address",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black54,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: controller.emailValidator,
                        onSaved: (value) => controller.setEmail(value ?? ''),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomTextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) => controller.setPassword(value),
                        containerWidth: 90.w,
                        hintText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black54,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        obscureText: !controller.isPasswordVisible,
                        validator: (value) =>
                            controller.passwordValidator(value),
                        onSaved: (value) => controller.setPassword(value ?? ''),
                      ),
                    ),
                    SizedBox(height: 1.h),

                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomTextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => () {},
                        containerWidth: 90.w,
                        hintText: "Confirm Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black54,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordAgainVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.togglePasswordAgainVisibility,
                        ),
                        obscureText: !controller.isPasswordAgainVisible,
                        validator: (value) =>
                            controller.confirmPasswordValidator(value),
                        onSaved: (_) {},
                      ),
                    ),

                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: ColorsManager.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.loginScreen),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: ColorsManager.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 2.h,
                    ),
                    // Sign Up Button
                    CustomElevatedButton(
                      width: 90.w,
                      onPressed: () {
                        controller.verify(_thisKey);
                      },
                      height: 7.h,
                      backgroundColor: ColorsManager.primary,
                      foregroundColor: ColorsManager.white,
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
