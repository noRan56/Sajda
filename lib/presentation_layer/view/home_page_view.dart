import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/dash_board.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/presentation_layer/view/azkar_list_page.dart';
import 'package:sajda/presentation_layer/view/bookmark_page.dart';
import 'package:sajda/presentation_layer/view/duaa_list_page.dart';
import 'package:sajda/presentation_layer/view/notifications_setting_page.dart';
import 'package:sajda/presentation_layer/view/prayer_time_page.dart';
import 'package:sajda/presentation_layer/view/surah_page.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(children: [const ImageBackg(), _buildContent(context)]),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Sajda', style: TextStyle(color: Colors.teal)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.teal),
          onPressed:
              () => _navigateTo(context, const NotificationSettingsScreen()),
        ),
      ],
      leading: const Icon(Icons.menu, color: Colors.teal),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            _buildLogo(),
            SizedBox(height: 10.h),
            _buildDuaaCard(context),
            SizedBox(height: 10.h),
            _buildFirstRowCards(context),
            SizedBox(height: 10.h),
            _buildSecondRowCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset('assets/logo.png', height: 100.h, width: 100.w),
    );
  }

  Widget _buildDuaaCard(BuildContext context) {
    return DashboardCard(
      width: 330.w,
      height: 100.h,
      gradientColors: CustomColors.greenGradient,
      onTap: () => _navigateTo(context, DuaaListPage()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/lamp.png'),
          SizedBox(width: 100.w),
          Text('من جوامع الكلم', style: CustomTextStyle.fontHome),
        ],
      ),
    );
  }

  Widget _buildFirstRowCards(BuildContext context) {
    return Row(
      children: [
        DashboardCard(
          width: 150.w,
          height: 150.h,
          gradientColors: CustomColors.lightGreenGradient,
          onTap: () => _navigateTo(context, SurahListScreen()),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                'assets/images/quran1.png',
                height: 60.h,
                width: 60.w,
              ),
              SizedBox(height: 30.h),
              Text('قرآن كريم', style: CustomTextStyle.fontHome),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        DashboardCard(
          width: 160.w,
          height: 120.h,
          gradientColors: CustomColors.lightGreenGradient,
          onTap: () => _navigateTo(context, PrayerTimeScreen()),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                'assets/images/prayer.png',
                height: 60.h,
                width: 60.w,
              ),
              SizedBox(height: 10.h),
              Text('مواقيت الصلاة', style: CustomTextStyle.fontHome),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecondRowCards(BuildContext context) {
    return Row(
      children: [
        DashboardCard(
          width: 130.w,
          height: 170.h,
          gradientColors: CustomColors.greenGradient,
          onTap: () => _navigateTo(context, FavoritesScreen()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                'assets/images/bookmark.png',
                width: 60.w,
                height: 60.h,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.all(12.0.w.h),
                child: Text('المفضلة', style: CustomTextStyle.fontHome),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        DashboardCard(
          width: 190.w,
          height: 140.h,
          gradientColors: CustomColors.lightGreenGradient,
          onTap: () => _navigateTo(context, const AzkarListPage()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.all(8.0.h.w),
                child: Image.asset(
                  'assets/images/moon.png',
                  width: 60.w,
                  height: 60.h,
                ),
              ),
              SizedBox(height: 10.h),

              Text('أذكارك ', style: CustomTextStyle.fontHome),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}
