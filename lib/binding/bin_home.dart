import 'package:get/get.dart';
import 'package:stopwatch/controller/con_home.dart';

class BindingHome extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ControllerHome());
  }
}
