import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/modules/popular/views/popular_list_view.dart';
import 'package:manav_movies/app/modules/top_rated/views/top_rated_view.dart';
import '../../../core/base/base_widget.dart';
import '../../../core/components/text_view.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/text_styles.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/main/model/menu_code.dart';
import '/app/modules/main/views/bottom_nav_bar.dart';

class MainView extends BaseWidget<MainController> {
  static const String SCREEN_NAME = 'main view';
  TopRatedListView? topRatedView;
  PopularListView? popularListView;

  MainView({super.key});
  final topRatedListKey = GlobalKey();
  final popularListKey = GlobalKey();

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.TOP_RATED:
        return topRatedView ??= TopRatedListView(
          key: topRatedListKey,
        );
      case MenuCode.POPULAR:
        popularListView ??= PopularListView(
          key: popularListKey,
        );
        return popularListView!;

      default:
        return Container();
    }
  }

  @override
  Widget? getBottomNavigationBar(BuildContext context) {
    return controller.bottomNavModel!.navItems.length >= 2
        ? BottomNavBar(
            mainController: controller,
            onTap: () async {
            },
          )
        : null;
  }

  @override
  Widget getBuildWidget(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx(() => getPageOnSelectedMenu(controller.selectedMenuCode)),
    );
  }

  @override
  Widget? getToolBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryRed,
      title: Obx(()=>TextView(
        title: getSelectedPageName(),
        textStyle: quicksand_16ptBold(color: white_100),
        id: "app_bar_title",
      )),
      elevation: 5,
    );
  }

  String getSelectedPageName() {
    switch (controller.selectedMenuCode) {
      case MenuCode.TOP_RATED:
        return getString("top_rated");
      case MenuCode.POPULAR:
        return getString('popular');
      default:
        return "default";
    }
  }

  @override
  bool overrideBackBehaviour() {
    return true;
  }

  @override
  void onBackPressManual() async {
if (Get.isSnackbarOpen || (Get.isBottomSheetOpen ?? false) || (Get.isDialogOpen ?? false)) {
      Get.back(closeOverlays: true);
    } else if (controller.selectedMenuCode == controller.defaultMenuCode) {
      if (controller.doubleTapFlag) {
        SystemNavigator.pop();
      } else {
        controller.doubleTapFlag = true;
        showToast(getString('textBackPressTwice'), showAsSnackBar: false);
        controller.cancelTimer();
        controller.startTimer();
      }
    } else {
      controller.onMenuSelected(controller.defaultMenuCode, controller.bottomNavModel!.initialSelectedIndex);
    }
  }

  @override
  void onScreenReady(BuildContext context, MainController controller) {
  }

}
