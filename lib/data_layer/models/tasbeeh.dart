import 'package:hive/hive.dart';
part 'tasbeeh.g.dart';

@HiveType(typeId: 1)
class Tasbeeh extends HiveObject {
  @HiveField(0)
  String phrase;
  @HiveField(1)
  int count;

  Tasbeeh({required this.phrase, this.count = 0});
}
