import 'package:flutter/material.dart';

class ImageBackg extends StatelessWidget {
  const ImageBackg({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/bg.png',
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
