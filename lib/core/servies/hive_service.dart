// services/hive_service.dart
import 'package:hive/hive.dart';

class HiveService {
  static const String prayerBoxName = 'prayer_times';
  static const String locationBoxName = 'user_location';

  static Future<void> init() async {
    await Hive.openBox(prayerBoxName);
    await Hive.openBox(locationBoxName);
  }

  static Future<void> savePrayerTimes(
    String key,
    Map<String, dynamic> timings,
  ) async {
    final box = Hive.box(prayerBoxName);
    await box.put(key, {
      'timings': timings,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Map<String, dynamic>? getPrayerTimes(String key) {
    try {
      final box = Hive.box(prayerBoxName);
      final storedData = box.get(key);

      if (storedData != null && storedData is Map) {
        final timestamp = storedData['timestamp'] as int?;

        if (timestamp != null) {
          final storedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
          final now = DateTime.now();

          // Check if data is from today
          if (storedDate.year == now.year &&
              storedDate.month == now.month &&
              storedDate.day == now.day) {
            final rawTimings = storedData['timings'];
            if (rawTimings is Map) {
              return Map<String, dynamic>.from(rawTimings);
            }
          }
        }
      }
    } catch (e) {
      print('Error getting prayer times from Hive: $e');
    }
    return null;
  }

  static Future<void> saveUserLocation(String city, String country) async {
    final box = Hive.box(locationBoxName);
    await box.put('location', {
      'city': city,
      'country': country,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  static Map<String, dynamic>? getUserLocation() {
    try {
      final box = Hive.box(locationBoxName);
      final locationData = box.get('location');

      if (locationData != null && locationData is Map) {
        final timestamp = locationData['timestamp'] as int?;

        if (timestamp != null) {
          final storedDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
          final now = DateTime.now();

          // Location data is valid for 7 days
          if (now.difference(storedDate).inDays < 7) {
            return {
              'city': locationData['city'] as String? ?? 'Cairo',
              'country': locationData['country'] as String? ?? 'Egypt',
            };
          }
        }
      }
    } catch (e) {
      print('Error getting location from Hive: $e');
    }
    return null;
  }
}
