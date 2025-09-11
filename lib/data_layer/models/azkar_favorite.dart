import 'package:hive/hive.dart';
part 'azkar_favorite.g.dart';

@HiveType(typeId: 2)
class AzkarFavorite extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  String text;

  AzkarFavorite({required this.category, required this.text});
}
