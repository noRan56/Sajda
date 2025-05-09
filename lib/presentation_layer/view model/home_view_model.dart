import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/styles/custom_text_style.dart';

class HomeViewModel extends StatefulWidget {
  const HomeViewModel({super.key});

  @override
  State<HomeViewModel> createState() => _HomeViewModelState();
}

class _HomeViewModelState extends State<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 150.h),
          Center(
            child: Text('10:10:10 PM', style: CustomTextStyle.font24Yellow),
          ),
          SizedBox(height: 20.h),

          Text('Cairo', style: CustomTextStyle.font20Yellow),
          Text('Egypt', style: CustomTextStyle.font20Yellow),
          Text('Date 10 / 10 / 2022', style: CustomTextStyle.font20Yellow),
          Text('Hajra / 10 / 2022', style: CustomTextStyle.font20Yellow),
          SizedBox(height: 30.h),

          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 6,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text('Cairo', style: CustomTextStyle.font18Yellow),
                  Spacer(),
                  Text('Egypt', style: CustomTextStyle.font18Yellow),
                ],
              );
            },
            separatorBuilder:
                (context, index) => const Divider(indent: 10, endIndent: 10),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}
