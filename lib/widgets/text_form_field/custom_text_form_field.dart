// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String) onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final double containerWidth;
  Text? label;
  TextEditingController? controller;
  String? initialValue;

  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.validator,
    required this.keyboardType,
    required this.obscureText,
    required this.onChanged,
    this.onSaved,
    this.onEditingComplete,
    required this.containerWidth,
    this.label,
    this.controller,
    this.initialValue,
  });

  Widget _enterCustomTextFormField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
        color: Colors.white.withOpacity(0.7),
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          label: label,
          suffixIcon: suffixIcon,
          icon: prefixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18.sp,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _enterCustomTextFormField(context);
  }
}
