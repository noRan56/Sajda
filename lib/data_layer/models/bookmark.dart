import 'package:hive/hive.dart';
part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark extends HiveObject {
  @HiveField(0)
  int surahId;
  @HiveField(1)
  int ayahNum;

  Bookmark({required this.surahId, required this.ayahNum});
}
