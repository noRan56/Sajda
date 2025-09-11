import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 107, 4, 121),
              const Color.fromARGB(255, 123, 22, 160),
              const Color.fromARGB(255, 161, 29, 198),
              const Color.fromARGB(255, 150, 69, 185),
              const Color.fromARGB(255, 218, 87, 218),
            ],
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Image.asset('assets/images/evAzkar.png', height: 70.h, width: 70.w),
            SizedBox(width: 70.w),
            Center(
              child: Text(
                " أذكار المساء ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
