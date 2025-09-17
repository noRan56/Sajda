import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
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
          gradient: CustomColors.greenGradient,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/moAzkar.png', height: 70.h, width: 70.w),
            SizedBox(width: 70.w),
            Text(
              " أذكار الصباح ",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Amiri",
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
