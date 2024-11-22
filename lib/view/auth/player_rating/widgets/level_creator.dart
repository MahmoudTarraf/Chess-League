import 'package:chess_league/model/levels_model.dart';
import 'package:chess_league/view/auth/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LevelCreator extends StatelessWidget {
  const LevelCreator({
    super.key,
    required this.levelList,
  });
  final List<LevelsModel> levelList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SignupController(),
      builder: (controller) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final thisItem = levelList[index];
          final isSelected = controller.selectedLevel == thisItem;
          return InkWell(
            onTap: () {
              controller.seletLevel(thisItem);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 50.w,
                padding:
                    const EdgeInsets.all(10.0), // Padding for the container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 3,
                    color: isSelected ? Colors.red : Colors.amber,
                  ),
                ),
                child: Center(
                  // Centers the Row within the container
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Shrinks Row to fit its children
                    children: [
                      Icon(
                        thisItem.iconData,
                        size: 30,
                      ),
                      SizedBox(width: 4.w), // Space between icon and text
                      Text(
                        thisItem.levelName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.red : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: levelList.length,
      ),
    );
  }
}
