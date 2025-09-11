import 'package:hive/hive.dart';

class FavoritesService {
  final Box favBox = Hive.box('favorites');

  Future<void> toggleFavorite(int surahNumber) async {
    if (favBox.containsKey(surahNumber)) {
      await favBox.delete(surahNumber);
    } else {
      await favBox.put(surahNumber, true);
    }
  }

  List<int> getFavorites() {
    return favBox.keys.cast<int>().toList();
  }

  bool isFavorite(int surahNumber) {
    return favBox.containsKey(surahNumber);
  }
}
