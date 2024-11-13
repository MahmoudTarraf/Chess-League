import 'package:flutter/material.dart';

class DeadPiece extends StatelessWidget {
  const DeadPiece({
    super.key,
    required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath);
  }
}
