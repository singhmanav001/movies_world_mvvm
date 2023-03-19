import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/core/components/universal_media_view.dart';
import 'package:manav_movies/app/core/values/app_colors.dart';
import '../../../core/base/base_widget.dart';
import '../../../core/components/text_view.dart';
import '../../../core/values/app_dimen.dart';
import '../../../core/values/app_images.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/values/semantic_id.dart';
import '../../../core/values/text_styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends BaseWidget<SplashController> {
  SplashView({Key? key}) : super(key: key);

  @override
  Widget getBuildWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: lightGrey,
      child: Stack(children: [
        IntrinsicHeight(child: UniversalMediaView(
          path: AppImages.splashLogo,
          imageWidth: MediaQuery.of(context).size.width,
          imageHeight: MediaQuery.of(context).size.height,
          id: SemanticsIds.iVSplash,
        ),),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: TextView(
          title: AppStrings.splashTitle,
          id: SemanticsIds.title,
          textAlign: TextAlign.center,
          textStyle: quicksand_20ptNormal(color: white_100),
          margin: const EdgeInsets.only(bottom: spacingXXL14),
        ),)
      ],),
    );
  }

  @override
  void onScreenReady(BuildContext context, SplashController controller) async {
  }
}
