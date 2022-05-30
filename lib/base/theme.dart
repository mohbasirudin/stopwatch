import 'package:flutter/material.dart';
import 'package:stopwatch/base/colors.dart';
import 'package:stopwatch/base/global.dart';

class AppTheme {
  static ThemeData base({
    required Color canvasColor,
    bool useDark = true,
  }) {
    return ThemeData(
      canvasColor: canvasColor,
      appBarTheme: AppBarTheme(
        backgroundColor: canvasColor,
        elevation: 4,
        // shadowColor: useDark ? AppColor.itemDark : AppColor.itemLight,
        shadowColor: Colors.blueGrey,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: useDark ? AppColor.itemDark : AppColor.itemLight,
          fontSize: 18,
        ),
      ),
    );
  }
}
