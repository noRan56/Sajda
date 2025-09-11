import 'package:hive/hive.dart';
import 'package:sajda/data_layer/models/azkar_favorite.dart';
import 'package:sajda/data_layer/models/bookmark.dart';
import 'package:sajda/data_layer/models/tasbeeh.dart';

class Boxes {
  static Box<Bookmark> bookmark() => Hive.box<Bookmark>('bookmark');
  static Box<Tasbeeh> tasbeeh() => Hive.box<Tasbeeh>('tasbeeh');
  static Box<AzkarFavorite> favAzkar() => Hive.box<AzkarFavorite>('fav_azkar');
}
