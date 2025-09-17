import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/presentation_layer/view/evening_azkar.dart';

class EvenningAzkar extends StatelessWidget {
  const EvenningAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => EveningAzkar()));
        // EveningAzkar
      },
      child: Container(
        height: 70.h,
        width: 340.w,
        decoration: BoxDecoration(
          gradient: CustomColors.lightGreenGradient,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/evAzkar.png', height: 70.h, width: 70.w),
            SizedBox(width: 70.w),
            Center(
              child: Text(
                " أذكار المساء ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Amiri",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
