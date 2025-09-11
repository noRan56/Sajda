import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sajda/core/servies/api_service.dart';
import 'package:sajda/core/servies/fav_services.dart';
import 'package:sajda/data_layer/models/surah.dart';
import 'package:sajda/presentation_layer/view/surah_detail_screen.dart';

class SurahListScreen extends StatefulWidget {
  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  final ApiService apiService = ApiService();
  final FavoritesService favoritesService = FavoritesService();
  List<int> favoriteSurahs = [];

  bool isFavorite(int surahNumber) => favoriteSurahs.contains(surahNumber);

  @override
  void initState() {
    super.initState();

    loadFavorites();
  }

  void loadFavorites() async {
    final favs = await favoritesService.getFavorites();
    setState(() {
      //

      favoriteSurahs = favs;
    });
  }

  void toggleFavorite(int surahNumber) async {
    await favoritesService.toggleFavorite(surahNumber);
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qur'an Surahs", style: TextStyle(color: Colors.teal)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: apiService.fetchSurahs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Surahs found"));
          }

          final surahs = snapshot.data!;
          return ListView.builder(
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              final isFav = isFavorite(surah.number);

              return Card(
                child: ListTile(
                  leading: Stack(
                    children: [
                      Image.asset(
                        'assets/images/numDesign.png',
                        color: Colors.teal,
                      ),
                      Positioned(
                        top: 13.h,

                        left: 18.w,
                        child: Center(
                          child: Text(
                            "${surah.number}",
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // leading: CircleAvatar(child: ),
                  title: Text(surah.name, textAlign: TextAlign.right),
                  subtitle: Text(
                    "${surah.englishName} | ${surah.revelationType}",
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => toggleFavorite(surah.number),
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
