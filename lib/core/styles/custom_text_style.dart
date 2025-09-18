import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';

class CustomTextStyle {
  static final font18Yellow = TextStyle(
    fontSize: 18.sp,
    color: CustomColors.yellow,
    fontWeight: FontWeight.w600,
  );
  static final font20Yellow = TextStyle(
    fontSize: 20.sp,
    color: CustomColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static final font24Yellow = TextStyle(
    fontSize: 24.sp,
    color: CustomColors.yellow,
    fontWeight: FontWeight.w400,
  );

  static final fontHome = TextStyle(
    fontSize: 18.sp,
    color: CustomColors.white,
    fontWeight: FontWeight.bold,
    fontFamily: "Amiri",
  );
  static final fontAzkar = TextStyle(
    fontSize: 17.sp,
    color: CustomColors.white,
    letterSpacing: 1.5,
    wordSpacing: 1.5,
    fontWeight: FontWeight.bold,
    fontFamily: "Amiri",
  );

  static final titleAppBar = TextStyle(
    fontSize: 22.sp,
    color: CustomColors.teal,
    fontWeight: FontWeight.bold,
    fontFamily: "Amiri",
  );

  static final font24White = TextStyle(
    color: Colors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    fontFamily: "Amiri",
  );
}
