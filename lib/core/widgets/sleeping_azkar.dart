import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/presentation_layer/view/sleep_azker.dart';

class SleepingAzkar extends StatelessWidget {
  const SleepingAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => SleepAzker()));
      },
      child: Container(
        height: 70.h,
        width: 340.w,
        decoration: BoxDecoration(
          gradient: CustomColors.greenGradient,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/sleeping.png',
              height: 70.h,
              width: 70.w,
            ),
            SizedBox(width: 70.w),
            Text(
              "أذكار قبل النوم ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontFamily: "Amiri",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
