import 'package:get/get.dart';
import 'package:manav_movies/app/modules/top_rated/controllers/top_rated_controller.dart';
import '../../popular/controllers/popular_controller.dart';
import '/app/modules/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());

    Get.lazyPut<PopularController>(
      () => PopularController(),
      fenix: true,
    );
    Get.lazyPut<TopRatedController>(
      () => TopRatedController(),
      fenix: true,
    );
  }
}
