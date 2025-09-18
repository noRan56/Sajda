import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final Color? color;

  const CustomCardWidget({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80.h,
        width: 340.w,
        decoration: BoxDecoration(
          color: color ?? Colors.teal,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imagePath, height: 70.h, width: 70.w),
            SizedBox(width: 70.w),
            Text(
              title,
              style: CustomTextStyle.font24White,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
