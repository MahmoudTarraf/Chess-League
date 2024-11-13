import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:chess_league/core/const_data/app_images.dart';
import 'package:chess_league/model/available_games.dart';
import 'package:chess_league/view/board/controller/board_controller.dart';
import 'package:chess_league/view/board/screen/board_screen.dart';
import 'package:chess_league/view/computer/controller/computer_controller.dart';
import 'package:chess_league/view/home/widgets/grid_item_builder.dart';
import 'package:chess_league/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ComputerScreen extends StatelessWidget {
  const ComputerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boardController = Get.find<BoardController>();
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.scaffoldBackColor,
        title: Text(
          'Play With Computer',
          style: TextStyle(
            color: ColorsManager.white,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder(
          init: ComputerController(),
          builder: (controller) {
            boardController.isVsComputer = true;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Choose Time Control:',
                        style: TextStyle(
                          color: ColorsManager.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 35.h,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          final thisItem = games[index];
                          return GestureDetector(
                            onTap: () => controller.updateColor(thisItem),
                            child: gridItemCreator(
                              thisItem.timeControl,
                              thisItem.gameName,
                              thisItem.gameBackColor,
                            ),
                          );
                        },
                        itemCount: 6,
                      ),
                    ),
                    Text(
                      'You Play:',
                      style: TextStyle(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () =>
                              controller.updatePlayerKingColor(kings[0]),
                          child: Container(
                            height: 10.h,
                            width: 20.w,
                            decoration:
                                BoxDecoration(color: kings[0].gameBackColor),
                            child: Image.asset(AppImages.blackKing),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        InkWell(
                          onTap: () =>
                              controller.updatePlayerKingColor(kings[1]),
                          child: Container(
                            height: 10.h,
                            width: 20.w,
                            decoration:
                                BoxDecoration(color: kings[1].gameBackColor),
                            child: Image.asset(AppImages.whiteKing),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Difficulty Level:',
                          style: TextStyle(
                            color: ColorsManager.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorsManager.backgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: ColorsManager.backgroundColor,
                            underline: Container(),
                            value: controller.difficultyLevel,
                            onChanged: (newValue) =>
                                controller.updateDifficulty(newValue!),
                            items: <String>['Easy', 'Normal', 'Hard']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorsManager.white,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomElevatedButton(
                        width: 80.w,
                        onPressed: () {
                          Get.to(() => const BoardScreen());
                        },
                        height: 7.h,
                        backgroundColor: ColorsManager.backgroundColor,
                        foregroundColor: ColorsManager.white,
                        child: Text(
                          'Play Now!',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
