// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:manav_movies/app/modules/popular/bindings/popular_binding.dart';
import 'package:manav_movies/app/modules/top_rated/views/top_rated_view.dart';

import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => SplashView(),
        binding: SplashBinding()),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.TOP_RATED,
          page: () => TopRatedListView(),
        ),
        GetPage(
          name: _Paths.POPULAR,
          page: () => TopRatedListView(),
          binding: PopularBinding(),
        )
      ],
    ),
  ];
}
