import 'package:hive/hive.dart';
import 'package:sajda/data_layer/models/tasbeeh.dart';

class TasbeehRepository {
  static const String boxName = 'tasbeehBox';

  /// فتح الـ Box (لازم يتعمل قبل الاستخدام)
  Future<Box<Tasbeeh>> _openBox() async {
    return await Hive.openBox<Tasbeeh>(boxName);
  }

  /// إضافة تسبيحة جديدة
  Future<void> addTasbeeh(Tasbeeh tasbeeh) async {
    final box = await _openBox();
    await box.add(tasbeeh);
  }

  /// تحديث العداد (زيادة +1)
  Future<void> incrementTasbeeh(int index) async {
    final box = await _openBox();
    final tasbeeh = box.getAt(index);
    if (tasbeeh != null) {
      tasbeeh.count++;
      await tasbeeh.save();
    }
  }

  /// إعادة التصفير
  Future<void> resetTasbeeh(int index) async {
    final box = await _openBox();
    final tasbeeh = box.getAt(index);
    if (tasbeeh != null) {
      tasbeeh.count = 0;
      await tasbeeh.save();
    }
  }

  /// مسح تسبيحة
  Future<void> deleteTasbeeh(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  /// جلب كل التسبيحات
  Future<List<Tasbeeh>> getAllTasbeehs() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// تصفير الكل
  Future<void> resetAll() async {
    final box = await _openBox();
    for (var tasbeeh in box.values) {
      tasbeeh.count = 0;
      await tasbeeh.save();
    }
  }
}
