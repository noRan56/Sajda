import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/servies/api_service.dart';
import 'package:sajda/core/servies/fav_services.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/data_layer/models/surah.dart';

import 'surah_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ApiService apiService = ApiService();
  final FavoritesService favoritesService = FavoritesService();
  List<int> favoriteSurahNumbers = [];
  List<Surah> allSurahs = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {
    final favs = await favoritesService.getFavorites();
    final surahs = await apiService.fetchSurahs();
    setState(() {
      favoriteSurahNumbers = favs;
      allSurahs = surahs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteSurahs =
        allSurahs
            .where((surah) => favoriteSurahNumbers.contains(surah.number))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(" ⭐️ المفضلة ", style: CustomTextStyle.titleAppBar),
        centerTitle: true,
      ),
      body:
          favoriteSurahs.isEmpty
              ? Center(child: Text("لا توجد سور مفضلة بعد"))
              : Stack(
                children: [
                  ImageBackg(),
                  ListView.builder(
                    itemCount: favoriteSurahs.length,
                    itemBuilder: (context, index) {
                      final surah = favoriteSurahs[index];
                      return ListTile(
                        leading: Stack(
                          children: [
                            Image.asset(
                              'assets/images/numDesign.png',
                              color: CustomColors.green1,
                            ),
                            Positioned(
                              top: 13.h,

                              left: 18.w,
                              child: Center(
                                child: Text(
                                  "${surah.number}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(surah.name, textAlign: TextAlign.right),
                        subtitle: Text(
                          "${surah.englishName} | ${surah.revelationType}",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SurahDetailScreen(
                                    surahNumber: surah.number,
                                    surahName: surah.name,
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
    );
  }
}
