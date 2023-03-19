import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/core/values/app_colors.dart';

import '../../../core/components/text_view.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/app_dimen.dart';
import '../../../core/values/text_styles.dart';

class PopularErrorWidget extends StatelessWidget {
  const PopularErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: spacingXXL20, left: spacingXXL20, right: spacingXXL20),
            child: Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: iconSize_28 * 2,
                  color: lightGrey,
                ),
                TextView(
                    margin: const EdgeInsets.only(top: spacingXXL6),
                    title: getString('something_went_wrong'),
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
