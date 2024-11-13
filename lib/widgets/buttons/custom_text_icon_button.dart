import 'package:chess_league/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle titleStyle;
  final Icon textButtonIcon;

  const CustomTextIconButton({
    required this.textButtonIcon,
    super.key,
    required this.title,
    required this.onPressed,
    required this.height,
    required this.width,
    // required this.width,
    this.padding = const EdgeInsets.all(16.0),
    required this.backgroundColor,
    required this.foregroundColor,
    this.titleStyle = const TextStyle(fontSize: 18.0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton.icon(
        icon: textButtonIcon,
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: ColorsManager.backgroundColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        label: Padding(
          padding: padding,
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}
