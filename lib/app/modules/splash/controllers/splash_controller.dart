import 'dart:async';

import 'package:get/get.dart';

import '../../../core/base/base_controller.dart';
import '../../../core/controllers/my_app_controller.dart';
import '../../../routes/app_pages.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    startTime();
  }

  startTime() async {
    return Timer(const Duration(seconds: 3), navigationPage);
  }

  Future<void> navigationPage() async {
    Get.offAllNamed(Routes.MAIN);
    Timer(const Duration(milliseconds: 300), () {
      Get.delete<SplashController>();
    });
  }
}
