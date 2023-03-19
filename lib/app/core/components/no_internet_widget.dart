import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/core/values/app_colors.dart';

import '../utils/utils.dart';
import '../values/app_dimen.dart';
import '../values/text_styles.dart';
import 'text_view.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: (Get.height / 2) - 200,
                left: spacingXXL20,
                right: spacingXXL20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.wifi,
                  size: iconSize_28 * 2,
                  color: lightGrey,
                ),
                TextView(
                    margin: const EdgeInsets.only(top: spacingXXL6),
                    title: getString('no_internet_message'),
                    textAlign: TextAlign.center,
                    textStyle: quicksand_14ptBold(color: darkGrey),
                    id: 'id'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
