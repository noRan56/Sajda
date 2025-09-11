import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        // EveningAzkar
      },
      child: Container(
        height: 70.h,
        width: 340.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 78, 42, 35),
              const Color.fromARGB(255, 211, 215, 223),
              const Color.fromARGB(255, 63, 61, 63),
              const Color.fromARGB(255, 94, 94, 95),
              const Color.fromARGB(255, 12, 14, 33),
            ],
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Image.asset(
              'assets/images/sleeping.png',
              height: 70.h,
              width: 70.w,
            ),
            SizedBox(width: 70.w),
            Center(
              child: Text(
                "أذكار قبل النوم ",
                style: TextStyle(color: Colors.white, fontSize: 24.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
