import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/presentation_layer/view/tasbeeh_view.dart';

class TasbeehWidget extends StatelessWidget {
  const TasbeehWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => TasbeehCounterScreen()));
        // EveningAzkar
      },
      child: Container(
        height: 80.h,
        width: 340.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade300,
              Colors.blue.shade400,
              Colors.blue.shade500,
              Colors.blue.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            Image.asset('assets/images/tasbih.png', height: 70.h, width: 70.w),
            Text(
              " مسبحة إلكترونية ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
