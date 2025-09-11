🕌 Sajda — Azkar, Qur'an & Prayer Times (Flutter)

Sajda is a Flutter mobile app that brings together Quran reading, daily Azkar (morning/evening/sleep), Du‘a, prayer times (based on the user’s location or manual city input), electronic Tasbeeh (counter), local caching with Hive, bookmarking for Surahs, and local notifications for Azkar and prayer reminders.

✨ Key Features

Qur’an

List of Surahs with number, Arabic name, English name, and revelation type (Makki/Madani).

Tap a Surah → view full ayahs (with right-to-left layout and verse numbers).

Bookmark Surahs for quick access.

Azkar & Du‘a

Built-in collections: Morning Azkar, Evening Azkar, and Sleep Du‘a.

Electronic Tasbeeh (counter) to help track recitations.

Save favorite Azkar.

Prayer Times

Fetch prayer timings from an online API (e.g. Aladhan).

Option: Automatic (by device location) or manual city/country input.

Local caching of fetched prayer times (Hive) for offline use.

Notifications

Local scheduled notifications for:

Daily Azkar (morning/evening/sleep).

Prayer time reminders (schedule automatically from API times).

Notifications scheduled automatically on first app run (no extra user action required).

Offline support (Hive)

Store Surahs, Ayahs, prayer times, favorites, bookmarks, and saved Azkar locally.

App works while offline using cached data.

Simple & Lightweight

Minimal, focused UI for reading and worship activities.

Easy to extend (change Azkar times, change notification preferences, etc.)

🛠️ Built With

Flutter

flutter_local_notifications
— local scheduling & notifications

hive & hive_flutter
— local persistent storage / caching

timezone
— correct scheduled times handling

http
— API calls (Aladhan or AlQuran.cloud)

[geolocator / geocoding] (optional) — for automatic location -> city

🚀 Quick Start

1. Clone repository
   git clone https://github.com/your-username/sajda-app.git
   cd sajda-app

2. Install dependencies
   flutter pub get

3. Android manifest (permissions)

Open android/app/src/main/AndroidManifest.xml and add the needed permissions (if targeting Android 12+/13+ add POST_NOTIFICATIONS and optionally SCHEDULE_EXACT_ALARM):

<!-- Notifications -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

<!-- Optional: exact alarms (Android 12+). Only if you specifically use exact alarms. -->
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />

<!-- Optional: to reschedule notifications after device reboot (if you implement boot receiver) -->
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />

Note: On Android 13+, the app must request the POST_NOTIFICATIONS runtime permission. For exact alarms you might need user action in settings.

4. Configure APIs (optional)

Prayer times API: configure base URL / method (e.g., Aladhan).

Qur’an API: e.g., https://api.alquran.cloud/v1/surah.

Set any API keys or base URLs in your configuration file (or .env) as your project requires.

5. Run the app
   flutter run

🗂 Project Structure (suggested)
lib/
├─ main.dart
├─ services/
│ ├─ api_service.dart # Quran & prayer times fetching + Hive caching
│ ├─ notification_service.dart # local notifications scheduling & init
│ └─ favorites_service.dart # Hive favorites / bookmarks
├─ data_layer/
│ └─ models/ # Surah, Ayah, PrayerTime, Dhikr, Tasbeeh, Bookmark adapters
├─ screens/
│ ├─ home_view.dart
│ ├─ surah_list_screen.dart
│ ├─ surah_detail_screen.dart
│ ├─ favorites_screen.dart
│ ├─ prayer_time_screen.dart
│ └─ azkar_screen.dart
└─ utils/
└─ timezone_helper.dart

⚙️ Notes & Implementation Tips

Hive

Register Hive adapters (for custom models) before opening boxes.

Use box.put(key, value) with stable keys (e.g., surah.number) to avoid duplicates.

Clear or putAll while refreshing to avoid duplicate entries.

Notifications

Initialize flutter_local_notifications in main() and request runtime notification permission.

Use timezone package and tz.TZDateTime when scheduling for correct time-zone handling.

Prefer AndroidScheduleMode.inexact fallback for devices that block exact alarms; request exact permissions only if necessary.

Reschedule notifications on app start (or implement a boot receiver to reschedule after device reboot).

Prayer Times

Store complete API response in Hive (timings + meta) but pass only timings to the model used for UI.

Provide a fallback cached result if network fails.

Offline Behavior

Always check Hive cache before calling the network (unless forceRefresh: true).

Show appropriate UI that data is loaded from cache when offline.

Bookmarks & Favorites

Keep favorites in a Hive box with Surah number as key (no duplicates).

For favorite Azkar, store their id/text in a separate Hive box.

Tasbeeh

Tasbeeh counter state can be persisted per-session in Hive so the count survives app restarts.

✅ Roadmap (future ideas)

Edit/customize Azkar times and notification preferences per user.

Add audio playback for Surah and Du‘a recitations.

Advanced scheduling: allow reminders a few minutes before prayer times.

iOS-specific adjustments and full iOS notification behavior.

Add unit & widget tests, CI workflow.

📄 License

This project is open source. Choose a license, e.g. MIT:

MIT License
