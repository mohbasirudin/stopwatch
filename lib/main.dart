import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stopwatch/base/colors.dart';
import 'package:stopwatch/base/routes.dart';
import 'package:stopwatch/base/theme.dart';
import 'package:stopwatch/binding/bin_home.dart';
import 'package:stopwatch/translation/languages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> locale = Platform.localeName.split("_");

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Locale(
        locale[0],
        locale[1],
      ),
      initialRoute: PageTo.home,
      initialBinding: BindingHome(),
      getPages: PageTo.route,
      themeMode: ThemeMode.light,
      theme: AppTheme.base(
        canvasColor: AppColor.light,
        useDark: false,
      ),
      darkTheme: AppTheme.base(
        canvasColor: AppColor.dark,
      ),
    );
  }
}
