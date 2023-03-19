import '../../../core/utils/utils.dart';
import 'bottom_nav_item.dart';

class BottomNavModel {
  int initialSelectedIndex;
  String nonSelectedColor;
  String selectedColor;

  List<BottomNavItem> navItems;

  BottomNavModel({
    required this.initialSelectedIndex,
    required this.nonSelectedColor,
    required this.selectedColor,
    required this.navItems,
  });

  factory BottomNavModel.fromJson(Map<String, dynamic> dataMap) {
    List items = getMapCheckedValue(dataMap, 'nav_menu', []);
    return BottomNavModel(
      initialSelectedIndex:
          getMapCheckedInt(dataMap, 'initial_selected_index', defaultValue: 0),
      nonSelectedColor: getMapCheckedString(dataMap, 'non_selected_color'),
      selectedColor: getMapCheckedString(dataMap, 'selected_color'),
      navItems: items.isEmpty
          ? <BottomNavItem>[]
          : items
              .map((e) => BottomNavItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
