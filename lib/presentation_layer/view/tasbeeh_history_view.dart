import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/data_layer/models/tasbeeh.dart';
import 'package:sajda/data_layer/rr/tasbeeh_repo.dart';

class TasbeehHistoryScreen extends StatelessWidget {
  const TasbeehHistoryScreen({Key? key}) : super(key: key);

  int _getTotal(Box<Tasbeeh> box) {
    int total = 0;
    for (var t in box.values) {
      total += t.count;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "سجل الأذكار",
          style: TextStyle(fontSize: 22.sp, color: Colors.teal.shade600),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<Tasbeeh>(TasbeehRepository.boxName).listenable(),
        builder: (context, Box<Tasbeeh> box, _) {
          final tasbeehs = box.values.toList();
          if (tasbeehs.isEmpty) {
            return const Center(
              child: Text("لا يوجد أذكار بعد", style: TextStyle(fontSize: 18)),
            );
          }

          return Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Stack(
              children: [
                ImageBackg(),
                Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: tasbeehs.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final t = tasbeehs[index];
                          return ListTile(
                            leading: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/numDesign.png',
                                  color: Colors.teal,
                                ),
                                Positioned(
                                  top: 13.h,

                                  left: 18.w,
                                  child: Center(
                                    child: Text(
                                      "${t.count}",
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            title: Text(
                              t.phrase,
                              style: const TextStyle(fontSize: 20),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.refresh,
                                    color: Colors.orange,
                                  ),
                                  tooltip: "تصفير",
                                  onPressed:
                                      () => TasbeehRepository().resetTasbeeh(
                                        index,
                                      ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  tooltip: "حذف",
                                  onPressed:
                                      () => TasbeehRepository().deleteTasbeeh(
                                        index,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // الإجمالي
                    Container(
                      width: 160.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          "الإجمالي: ${_getTotal(box)}",
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
