import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:sajda/core/servies/hive_service.dart';
import 'package:sajda/data_layer/models/ayah_model.dart';
import 'package:sajda/data_layer/models/prayer_time_model.dart';
import 'package:sajda/data_layer/models/surah.dart';

class ApiService {
  static const String baseUrl = "https://api.alquran.cloud/v1/surah";

  Future<List<Surah>> fetchSurahs({bool forceRefresh = false}) async {
    final surahBox = Hive.box('surahs');

    if (!forceRefresh && surahBox.isNotEmpty) {
      return surahBox.values
          .map((json) => Surah.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List surahs = data['data'];

      await surahBox.clear();

      final Map<int, dynamic> cacheMap = {for (var s in surahs) s['number']: s};
      await surahBox.putAll(cacheMap);

      return surahs.map((e) => Surah.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load Surahs");
    }
  }

  Future<List<Ayah>> fetchSurahDetail(
    int surahNumber, {
    bool forceRefresh = false,
  }) async {
    final ayahBox = Hive.box('ayahs');

    if (!forceRefresh && ayahBox.containsKey(surahNumber)) {
      final List stored = ayahBox.get(surahNumber);
      return stored
          .map((json) => Ayah.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    }

    final response = await http.get(Uri.parse("$baseUrl/$surahNumber"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List ayahs = data['data']['ayahs'];

      await ayahBox.put(surahNumber, ayahs);

      return ayahs.map((e) => Ayah.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load Surah details");
    }
  }

  // Future<PrayerTime> fetchPrayerTimes({
  //   required String city,
  //   required String country,
  //   bool forceRefresh = false,
  // }) async {
  //   final prayerBox = await Hive.openBox('prayer_times');

  //   final key = '$city-$country';

  //   if (!forceRefresh && prayerBox.containsKey(key)) {
  //     final storedData = prayerBox.get(key);
  //     print("🔹 Data from Hive for $key => $storedData");

  //     final json = Map<String, dynamic>.from(storedData);

  //     final timings = Map<String, dynamic>.from(json['timings']);

  //     return PrayerTime.fromJson(timings);
  //   }

  //   final url = Uri.parse(
  //     'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=5',
  //   );

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     final timings = Map<String, dynamic>.from(data['data']['timings']);
  //     print("✅ API timings => $timings");

  //     await prayerBox.put(key, data['data']);

  //     return PrayerTime.fromJson(timings);
  //   } else {
  //     throw Exception('فشل في جلب مواقيت الصلاة من API');
  //   }
  // }

  Future<PrayerTime> fetchPrayerTimes({
    required String city,
    required String country,
    bool forceRefresh = false,
  }) async {
    // Check if we have cached data
    if (!forceRefresh) {
      final cachedData = HiveService.getPrayerTimes('$city-$country');
      if (cachedData != null) {
        try {
          final timings = Map<String, dynamic>.from(
            cachedData['timings'] ?? {},
          );
          return PrayerTime.fromJson(timings);
        } catch (e) {
          print('Error parsing cached data: $e');
          // Continue to fetch from API if cached data is invalid
        }
      }
    }

    final url = Uri.parse(
      'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=5',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prayerData = data['data'];
      final timings = Map<String, dynamic>.from(prayerData['timings']);

      // Save to Hive
      await HiveService.savePrayerTimes('$city-$country', prayerData);

      return PrayerTime.fromJson(timings);
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
