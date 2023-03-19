import 'package:get/get.dart';
import 'package:manav_movies/app/modules/popular/controllers/popular_controller.dart';

class PopularBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopularController>(
      () => PopularController(),
    );
  }
}
