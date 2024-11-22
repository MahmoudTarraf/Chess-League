import 'package:chess_league/core/class/status_request.dart';
import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/core/service/routes.dart';
import 'package:chess_league/view/auth/login/controller/login_controller.dart';
import 'package:chess_league/widgets/buttons/custom_elevated_button.dart';
import 'package:chess_league/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> thatKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: GetBuilder(
          init: LoginController(),
          builder: (controller) => Form(
            key: thatKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2.h),
                  ClipOval(
                    child: Container(
                      color: Colors.transparent, // Background color, if needed
                      child: SvgPicture.asset(
                        AppImages.chessLanding,
                        width: 50.w, // Adjust to fit the desired size
                        height: 25.h, // Adjust to fit the desired size
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Continue Playing Chess!",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: ColorsManager.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: CustomTextFormField(
                      suffixIcon: null,
                      containerWidth: 90.w,
                      hintText: "Email Address",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black54,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      validator: (value) => controller.emailValidator(value),
                      onChanged: (_) => () {},
                      onSaved: (value) => controller.setEmail(value ?? ''),
                      onEditingComplete: () {},
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: CustomTextFormField(
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      obscureText: !controller.isPasswordVisible,
                      containerWidth: 90.w,
                      hintText: "Password",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black54,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => controller.passwordValidator(value),
                      onChanged: (_) => () {},
                      onSaved: (value) => controller.setPassword(value ?? ''),
                      onEditingComplete: () {},
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
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: ColorsManager.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.signupScreen),
                          child: Text(
                            'Signup',
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
                    height: 4.h,
                  ),
                  CustomElevatedButton(
                    width: 90.w,
                    onPressed: () {
                      controller.verify(thatKey);
                    },
                    height: 7.h,
                    backgroundColor: ColorsManager.primary,
                    foregroundColor: ColorsManager.white,
                    child: controller.statusRequest == StatusRequest.loading
                        ? const CircularProgressIndicator(
                            color: ColorsManager.white,
                          )
                        : Text(
                            "Login",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
