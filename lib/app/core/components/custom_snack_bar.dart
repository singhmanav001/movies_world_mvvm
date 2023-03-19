import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../values/app_colors.dart';
import '../values/app_dimen.dart';
import '../values/app_images.dart';
import '../values/text_styles.dart';
import 'custom_ink_well.dart';
import 'text_view.dart';
import 'universal_media_view.dart';

class CustomSnackBar extends StatefulWidget {
  final Function? snackBarOnTap;
  final Color snackBarColorBackground;
  final Color snackBarTopColor;
  final Color snackBarTextColor;
  final String message;
  final bool showCrossBtn;

  const CustomSnackBar({
    Key? key,
    this.snackBarColorBackground = Colors.black,
    this.snackBarTopColor = primaryRed,
    this.snackBarTextColor = white_100,
    this.snackBarOnTap,
    required this.message,
    this.showCrossBtn = true,
  }) : super(key: key);

  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> with TickerProviderStateMixin {
  late SnackBarController controller;
  late AnimationController controllerAnimation;

  @override
  void initState() {
    controller = Get.put(SnackBarController());
    controllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        controller.progress.value = controllerAnimation.value;
      });
    super.initState();

    controllerAnimation.forward();
  }

  @override
  void dispose() {
    controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.snackBarColorBackground,
        child: Column(
          children: [
            ClipRRect(
              child: Obx(() {
                return LinearProgressIndicator(
                  value: controller.progress.value,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.snackBarTopColor),
                  backgroundColor: lightGrey,
                );
              }),
            ),
            Container(
              padding: const EdgeInsets.all(spacingXXL2),
              child: Row(
                children: [
                  Expanded(
                    child: TextView(
                      id: '',
                      title: widget.message,
                      textStyle: h4_20ptRegular(color: widget.snackBarTextColor),
                    ),
                  ),
                  if (widget.showCrossBtn)
                    CustomInkWell(
                      onTap: widget.snackBarOnTap != null
                          ? widget.snackBarOnTap!()
                          : () {
                              Get.back();
                              // controller.stop(canceled  : true);
                            },
                      id: '',
                      child: UniversalMediaView(
                        id: '',
                        path: AppImages.cancelRounded,
                        margin: const EdgeInsets.only(left: spacingXXL2),
                      ),
                    )
                ],
              ),
            ),
          ],
        ));
  }
}

class SnackBarController extends GetxController {
  var progress = 0.0.obs;
}
