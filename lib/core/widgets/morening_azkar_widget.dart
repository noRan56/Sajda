import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/presentation_layer/view/azkar_page_view.dart';

class MoreningAzkarWidget extends StatelessWidget {
  const MoreningAzkarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => AzkarPageView()));
        // EveningAzkar
      },
      child: Container(
        height: 70.h,
        width: 340.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade200,
              Colors.pink.shade300,
              Colors.pink.shade400,
              Colors.pink.shade500,
              Colors.pink.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Image.asset('assets/images/moAzkar.png', height: 70.h, width: 70.w),
            SizedBox(width: 70.w),
            Text(
              " أذكار الصباح ",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
