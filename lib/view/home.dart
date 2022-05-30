import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stopwatch/base/colors.dart';
import 'package:stopwatch/base/global.dart';
import 'package:stopwatch/base/routes.dart';
import 'package:stopwatch/controller/con_home.dart';
import 'package:stopwatch/translation/languages.dart';
import 'package:stopwatch/translation/locale.dart';
import 'package:stopwatch/widget/button_circle.dart';

class Home extends GetView<ControllerHome> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stopwatch",
        ),
        actions: [
          IconButton(
            onPressed: () {
              String myLocale = DataGlobal.locale;
              if (myLocale == AppLocale.enUS) {
                myLocale = AppLocale.idID;
              } else {
                myLocale = AppLocale.enUS;
              }
              DataGlobal.locale = myLocale;
              List<String> locale = myLocale.split("_");
              Get.updateLocale(
                Locale(
                  locale[0],
                  locale[1],
                ),
              );
            },
            icon: Obx(
              () => Text(
                Languages.locale.tr,
                style: TextStyle(
                  color: DataGlobal.isDark.value
                      ? AppColor.itemDark
                      : AppColor.itemLight,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (DataGlobal.isDark.value) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
              DataGlobal.isDark.value = !DataGlobal.isDark.value;
            },
            icon: Obx(
              () => Icon(
                DataGlobal.isDark.value
                    ? Icons.mode_night_rounded
                    : Icons.wb_sunny_rounded,
                color: DataGlobal.isDark.value ? Colors.white : Colors.amber,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Text(
                      "${controller.hour.value}:${controller.minute.value}:${controller.second.value}",
                      style: GoogleFonts.bebasNeue(
                        color: DataGlobal.isDark.value
                            ? AppColor.itemDark
                            : AppColor.itemLight,
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.millisecond.value.toString(),
                      style: GoogleFonts.bebasNeue(
                        color: DataGlobal.isDark.value
                            ? AppColor.itemDark
                            : AppColor.itemLight,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Obx(
                        () => Text(
                          Languages.history.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: DataGlobal.isDark.value
                                ? AppColor.itemDark
                                : AppColor.itemLight,
                          ),
                        ),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (controller.histories.isNotEmpty) {
                              controller.histories.clear();
                            }
                          },
                          child: Text(
                            Languages.clear.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: controller.histories.isEmpty
                                  ? (DataGlobal.isDark.value
                                      ? AppColor.itemDark.withOpacity(0.5)
                                      : AppColor.itemLight.withOpacity(0.5))
                                  : Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      if (controller.histories.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(
                            top: 8,
                          ),
                          itemCount: controller.histories.length,
                          itemBuilder: (context, index) {
                            return _itemHistory(index: index);
                          },
                        );
                      } else {
                        return Center(
                          child: Obx(
                            () => Text(
                              Languages.emptyHistory.tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: DataGlobal.isDark.value
                                    ? AppColor.itemDark
                                    : AppColor.itemLight,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => ButtonCircle(
                    onTap: () {
                      if (!controller.isStart.value) {
                        controller.start();
                      } else {
                        controller.pause();
                      }
                    },
                    icon: !controller.isStart.value
                        ? Icons.play_arrow_rounded
                        : Icons.pause_rounded,
                    activeColor: DataGlobal.isDark.value
                        ? AppColor.itemDark
                        : AppColor.itemLight,
                    inactiveColor: AppColor.inactive,
                    enable: true,
                  ),
                ),
                Obx(
                  () => ButtonCircle(
                    onTap: () {
                      controller.stop();
                    },
                    icon: Icons.stop_rounded,
                    activeColor: Colors.redAccent,
                    inactiveColor: AppColor.inactive,
                    hoverColor: Colors.redAccent,
                    enable:
                        !controller.isStart.value && controller.isPause.value,
                  ),
                ),
                Obx(
                  () => ButtonCircle(
                    onTap: () {
                      controller.add();
                    },
                    icon: Icons.add_rounded,
                    activeColor: DataGlobal.isDark.value
                        ? AppColor.itemDark
                        : AppColor.itemLight,
                    inactiveColor: AppColor.inactive,
                    enable:
                        controller.isStart.value || controller.isPause.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemHistory({required int index}) {
    Color dark = AppColor.dark.withOpacity(0.1);
    Color light = AppColor.light.withOpacity(0.1);
    return Obx(
      () => Container(
        color: index % 2 == 0
            ? (DataGlobal.isDark.value ? light : dark)
            : (DataGlobal.isDark.value ? dark : light),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${index + 1}.",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
            Text(
              controller.histories[index],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
