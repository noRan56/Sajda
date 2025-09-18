import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/servies/api_service.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/data_layer/models/ayah_model.dart';

class SurahDetailScreen extends StatelessWidget {
  final int surahNumber;
  final String surahName;

  SurahDetailScreen({required this.surahNumber, required this.surahName});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade50,
        title: Text(
          surahName,
          style: CustomTextStyle.titleAppBar,
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Ayah>>(
        future: apiService.fetchSurahDetail(surahNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (snapshot.hasError) {
            return Center(child: Text("خطأ: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("لا توجد آيات"));
          }

          final ayahs = snapshot.data!;

          return Stack(
            children: [
              ImageBackg(),
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 22.sp,
                      height: 1.3.h,
                      fontFamily: "Amiri",
                      color: Colors.black,
                    ),
                    children: [
                      ...ayahs.map((ayah) {
                        return TextSpan(
                          children: [
                            TextSpan(text: ayah.text),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: _ayahNumberCircle(ayah.numberInSurah),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _ayahNumberCircle(int number) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/star.png',
          height: 35.h,
          width: 35.w,
          color: Colors.black,
        ),
        Positioned(
          top: 4.h,
          right: 12.w,
          child: Text(
            number == 0 ? "**" : "$number",
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: "Amiri",
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
