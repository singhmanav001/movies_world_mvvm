import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/base/base_controller.dart';
import '../../../core/utils/utils.dart';
import '../model/bottom_nav_model.dart';
import '../model/menu_code.dart';

class MainController extends BaseController {
  final _selectedMenuCodeController = MenuCode.TOP_RATED.obs;
  bool doubleTapFlag = false;
  Timer? _timer;
  int _tickerTime = 0;
  BottomNavModel? bottomNavModel;

  MenuCode get selectedMenuCode => _selectedMenuCodeController.value;
  late MenuCode defaultMenuCode;


  final _selectedIndexController = 0.obs;

  int get selectedIndex => _selectedIndexController.value;

  onMenuSelected(MenuCode menuCode, int index) async {
    _selectedMenuCodeController(menuCode);
    _selectedIndexController(index);
  }

  @override
  void onInit() async {
    getBottomNavData();
    if (bottomNavModel != null && bottomNavModel!.initialSelectedIndex >= 0 && bottomNavModel!.initialSelectedIndex < bottomNavModel!.navItems.length) {
      _selectedMenuCodeController.value = getMenuCode(bottomNavModel!.navItems.elementAt(bottomNavModel!.initialSelectedIndex).id);
      _selectedIndexController.value = bottomNavModel!.initialSelectedIndex;
      defaultMenuCode = _selectedMenuCodeController.value;
    }
    super.onInit();
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      doubleTapFlag = false;
      _tickerTime = 0;
    }
  }

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_tickerTime == 5) {
        cancelTimer();
      } else {
        _tickerTime++;
      }
    });
  }

  void getBottomNavData() {
    String value = "{\"non_selected_color\":\"#FF219653\",\"nav_menu\":[{\"image_selected\":\"https://bijak-public-images.s3.ap-south-1.amazonaws.com/app/ic_nav_home_selected.svg\",\"id\":\"top_rated\",\"title\":\"Top Rated\",\"image_non_selected\":\"https://bijak-public-images.s3.ap-south-1.amazonaws.com/app/ic_nav_home.svg\"},{\"image_selected\":\"https://bijak-public-images.s3.ap-south-1.amazonaws.com/app/ic_nav_watchlist_selected.svg\",\"id\":\"popular\",\"title\":\"Popular\",\"image_non_selected\":\"https://bijak-public-images.s3.ap-south-1.amazonaws.com/app/ic_nav_watchlist.svg\"}],\"initial_selected_index\":0.0,\"selected_color\":\"0xFF198548\"}";
    Map<String, dynamic> map = json.decode(value);
    bottomNavModel =   BottomNavModel.fromJson(map);
  }
}
