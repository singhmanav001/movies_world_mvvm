import '../../../core/utils/utils.dart';

class BottomNavItem {
  final String id;
  final String title;
  final String image;
  final String imageSelected;

  const BottomNavItem({
    required this.id,
    required this.title,
    required this.image,
    required this.imageSelected,
  });

  factory BottomNavItem.fromJson(Map<String, dynamic> dataMap) {
    return BottomNavItem(
      id: getMapCheckedString(dataMap, 'id'),
      title: getMapCheckedString(dataMap, 'title'),
      image: getMapCheckedString(dataMap, 'image_non_selected'),
      imageSelected: getMapCheckedString(dataMap, 'image_selected'),
    );
  }
}
