import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sajda/core/styles/custom_colors.dart';
import 'package:sajda/core/styles/custom_text_style.dart';
import 'package:sajda/core/widgets/image_backg.dart';
import 'package:sajda/data_layer/models/tasbeeh.dart';
import 'package:sajda/data_layer/rr/tasbeeh_repo.dart';
import 'package:sajda/presentation_layer/view/tasbeeh_history_view.dart';

class TasbeehCounterScreen extends StatefulWidget {
  const TasbeehCounterScreen({Key? key}) : super(key: key);

  @override
  State<TasbeehCounterScreen> createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen> {
  final repo = TasbeehRepository();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final all = await repo.getAllTasbeehs();
    if (all.isEmpty) {
      await repo.addTasbeeh(Tasbeeh(phrase: "سبحان الله"));
      await repo.addTasbeeh(Tasbeeh(phrase: "الحمد لله"));
      await repo.addTasbeeh(Tasbeeh(phrase: "لا إله إلا الله"));
      await repo.addTasbeeh(Tasbeeh(phrase: "الله أكبر"));
      await repo.addTasbeeh(Tasbeeh(phrase: "أستغفر الله"));

      await repo.addTasbeeh(Tasbeeh(phrase: "صلاة على النبي"));
      await repo.addTasbeeh(
        Tasbeeh(
          phrase:
              " لا اله الا الله وحده لا شريك له له الملك وله الحمد وهو على كل شيء قدير",
        ),
      );
      setState(() {});
    }
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("مسبحة إلكترونية", style: CustomTextStyle.titleAppBar),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TasbeehHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<Tasbeeh>(TasbeehRepository.boxName).listenable(),
        builder: (context, Box<Tasbeeh> box, _) {
          final tasbeehs = box.values.toList();
          if (tasbeehs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.teal),
            );
          }

          final current = tasbeehs[selectedIndex];

          return Stack(
            children: [
              ImageBackg(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dropdown لاختيار الذكر
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: DropdownButton<int>(
                      value: selectedIndex,
                      items: List.generate(
                        tasbeehs.length,
                        (i) => DropdownMenuItem(
                          value: i,
                          child: Text(
                            tasbeehs[i].phrase,
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedIndex = val!;
                        });
                      },
                    ),
                  ),

                  // العدد الحالي
                  Text(
                    "العدد: ${current.count}",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  GestureDetector(
                    onTap: () => repo.incrementTasbeeh(selectedIndex),
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.green3,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.r,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          current.phrase,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // الإجمالي
                  Text(
                    "الإجمالي: ${_getTotal(box)}",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => repo.resetTasbeeh(selectedIndex),
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: const Text(
                          "تصفير الحالي",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.green4,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      ElevatedButton.icon(
                        onPressed: () => repo.resetAll(),
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "تصفير الكل",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
