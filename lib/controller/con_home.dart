import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pausable_timer/pausable_timer.dart';

class ControllerHome extends GetxController {
  RxList<String> histories = <String>[].obs;
  Timer? _timer;
  RxBool isStart = false.obs;
  RxBool isPause = false.obs;
  RxString millisecond = "000".obs;
  RxString second = "00".obs;
  RxString minute = "00".obs;
  RxString hour = "00".obs;
  int _millisecond = 0;
  int _second = 0;
  int _minute = 0;
  int _hour = 0;
  int _maxTime = 60;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void start() {
    isStart.value = true;
    isPause.value = false;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _timer = timer;

      if (_millisecond >= (100 - 1)) {
        if (_second >= (_maxTime - 1)) {
          if (_minute >= (_maxTime - 1)) {
            _hour++;
            _minute = 0;

            if (_hour < 10) {
              hour.value = "0$_hour";
            } else {
              hour.value = "$_hour";
            }
          } else {
            _minute++;
            _second = 0;

            if (_minute < 10) {
              minute.value = "0$_minute";
            } else {
              minute.value = "$_minute";
            }
          }
        } else {
          _second++;
          _millisecond = 0;

          if (_second < 10) {
            second.value = "0$_second";
          } else {
            second.value = "$_second";
          }
        }
      } else {
        _millisecond++;

        if (_millisecond < 10) {
          millisecond.value = "0$_millisecond";
        // } else if (_millisecond >= 10 && _millisecond < 100) {
        //   millisecond.value = "0$_millisecond";
        } else {
          millisecond.value = "$_millisecond";
        }
      }
    });
  }

  void pause() {
    if (_timer != null && _timer!.isActive) {
      isStart.value = false;
      isPause.value = true;
      _timer!.cancel();
    }
  }

  void stop() {
    isStart.value = false;
    isPause.value = false;

    _millisecond = 0;
    _second = 0;
    _minute = 0;
    _hour = 0;

    millisecond.value = "00$_millisecond";
    second.value = "0$_second";
    minute.value = "0$_minute";
    hour.value = "0$_hour";
  }

  void add() {
    String time = "${hour.value}:${minute.value}"
        ":${second.value}.${millisecond.value}";
    histories.insert(0, time);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _close();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _close();
  }

  void _close() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
