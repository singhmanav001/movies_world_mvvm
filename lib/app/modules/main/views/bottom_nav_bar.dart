import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/universal_media_view.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/text_styles.dart';
import '../controllers/main_controller.dart';
import '/app/core/values/app_colors.dart';
import '/app/modules/main/model/bottom_nav_item.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  final MainController mainController;
  final Future<void> Function()? onTap;

  BottomNavBar({Key? key, required this.mainController, this.onTap}) : super(key: key);

  final Key bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        key: bottomNavKey,
        items: mainController.bottomNavModel!.navItems
            .map(
              (BottomNavItem navItem) => BottomNavigationBarItem(
                  icon: UniversalMediaView(
                    path: mainController.bottomNavModel!.navItems.indexOf(navItem) == mainController.selectedIndex ? navItem.imageSelected : navItem.image,
                    fit: BoxFit.contain,
                    id: '',
                    tintColor: mainController.bottomNavModel!.navItems.indexOf(navItem) == mainController.selectedIndex ? darkGrey : darkGrey,
                  ),
                  label: navItem.title,
                  tooltip: ""),
            )
            .toList(),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: subTitle2_14ptBold(color: stringToColor(mainController.bottomNavModel!.selectedColor, darkGrey)),
        unselectedLabelStyle: caption12ptRegular(color: stringToColor(mainController.bottomNavModel!.nonSelectedColor, darkGrey)),
        type: BottomNavigationBarType.fixed,
        backgroundColor: white_100,
        selectedItemColor: darkGrey,
        unselectedItemColor: darkGrey,
        currentIndex: mainController.selectedIndex,
        onTap: (index) async {
          await onTap!();
          mainController.onMenuSelected(getMenuCode(mainController.bottomNavModel!.navItems[index].id), index);
        },
      ),
    );
  }

// List<BottomNavItem> _getNavItems() {
//   return [
//     BottomNavItem(navTitle: getString('home'), icon: "images/icons_svg/ic_nav_home.svg", iconSelected: "images/icons_svg/ic_nav_home_selected.svg", menuCode: MenuCode.HOME),
//     BottomNavItem(navTitle: getString('watch_list'), icon: "images/icons_svg/ic_nav_watchlist.svg", iconSelected: "images/icons_svg/ic_nav_watchlist_selected.svg", menuCode: MenuCode.WATCHLIST),
//     BottomNavItem(navTitle: getString('queries'), icon: "images/icons_svg/ic_nav_queries.svg", iconSelected: "images/icons_svg/ic_nav_queries_selected.svg", menuCode: MenuCode.QUERIES)
//   ];
// }
}
