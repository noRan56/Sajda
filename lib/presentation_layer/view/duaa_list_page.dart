import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/widgets/evening_azkar.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/core/widgets/morening_azkar_widget.dart';
import 'package:sajda/core/widgets/shared_widget.dart';
import 'package:sajda/core/widgets/sleeping_azkar.dart';
import 'package:sajda/core/widgets/tasbeeh_widget.dart';
import 'package:sajda/presentation_layer/view/duaa_for_dead.dart';
import 'package:sajda/presentation_layer/view/duaa_for_self.dart';
import 'package:sajda/presentation_layer/view/duaa_nabwy.dart';
import 'package:sajda/presentation_layer/view/duaa_qurany.dart';
import 'package:sajda/presentation_layer/view/notifications_setting_page.dart';
import 'package:sajda/presentation_layer/view/wake_up_Azkar.dart';

class DuaaListPage extends StatelessWidget {
  const DuaaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "✨ من جوامع الكلم",
          style: TextStyle(
            fontFamily: "Amiri",
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          ImageBackg(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.w.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  CustomCardWidget(
                    color: CustomColors.green2,
                    imagePath: 'assets/images/heart.png',
                    title: 'سَلوان',
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DuaaForSelf(),
                          ),
                        ),
                  ),
                  SizedBox(height: 20.h),
                  CustomCardWidget(
                    color: CustomColors.green4,
                    imagePath: 'assets/images/4.png',
                    title: ' زاد المسلم',
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => DuaaNabwy()),
                        ),
                  ),
                  SizedBox(height: 20.h),
                  CustomCardWidget(
                    color: CustomColors.green2,
                    imagePath: 'assets/images/u.png',
                    title: 'رحمة وشفاء',
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => DuaaQurany()),
                        ),
                  ),
                  SizedBox(height: 20.h),
                  CustomCardWidget(
                    color: CustomColors.green4,
                    imagePath: 'assets/images/4.png',
                    title: 'رحمات',
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DuaaForDead(),
                          ),
                        ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
