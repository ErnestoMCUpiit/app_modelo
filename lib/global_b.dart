
import 'package:app_modelo/scan_controller.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<scanController>(() => scanController());
  }

}