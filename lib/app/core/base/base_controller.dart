import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/app_constants.dart';

abstract class BaseController extends GetxController {
  void scrollToTop(ScrollController? scrollController) {
    if (scrollController != null && scrollController.hasClients) {
      int time = AppConstants.scrollToTopTime;
      if (scrollController.position.pixels > 2000) {
        int d = scrollController.position.pixels.toInt() - 2000 > 500 ? ((scrollController.position.pixels.toInt() - 2000) ~/ 500).toInt() * 100 : 100;
        time = time + d;
      }
      scrollController.animateTo(0.0, duration: Duration(milliseconds: time), curve: Curves.easeOut);
    }
  }

  bool canBackScreen(ScrollController? scrollController) {
    if (scrollController != null) {
      if (scrollController.hasClients && scrollController.position.pixels != 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
