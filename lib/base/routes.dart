import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stopwatch/binding/bin_home.dart';
import 'package:stopwatch/view/home.dart';

class PageTo {
  static const home = "/home";

  static List<GetPage> route = [
    _getPage(
      name: home,
      page: const Home(),
      binding: BindingHome(),
    ),
  ];

  static GetPage _getPage({
    required String name,
    required Widget page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      page: () => page,
      binding: binding,
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(
        milliseconds: 400,
      ),
    );
  }
}
