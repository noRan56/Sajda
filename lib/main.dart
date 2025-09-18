import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sajda/core/servies/hive_service.dart';
import 'package:sajda/core/servies/notifications_servies.dart';
import 'package:sajda/data_layer/models/azkar_favorite.dart';
import 'package:sajda/data_layer/models/bookmark.dart';
import 'package:sajda/data_layer/models/tasbeeh.dart';
import 'package:sajda/presentation_layer/view/home_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService.init();

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
  await Hive.initFlutter();
  await HiveService.init();
  await LocalNotificationService.scheduleDailyAzkar();

  Hive.registerAdapter(BookmarkAdapter());
  Hive.registerAdapter(TasbeehAdapter());
  Hive.registerAdapter(AzkarFavoriteAdapter());

  await Hive.openBox('surahs');
  await Hive.openBox('ayahs');
  await Hive.openBox('favorites');
  await Hive.openBox('prayers');

  await Hive.openBox<Bookmark>('bookmark');

  await Hive.openBox<Tasbeeh>('tasbeehBox');

  await Hive.openBox<AzkarFavorite>('fav_azkar');
  runApp(const Sajda());
}

class Sajda extends StatelessWidget {
  const Sajda({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sajda',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const HomeViewPage(),
        );
      },
    );
  }
}
