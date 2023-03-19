import 'package:flutter/material.dart';

import '../../../core/components/text_view.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_dimen.dart';
import '../../../core/values/text_styles.dart';

class TopRatedEmptyView extends StatelessWidget {
  const TopRatedEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: spacingXXL26, left: spacingXXL20, right: spacingXXL20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: spacingXXS, bottom: spacingXXS),
            padding: const EdgeInsets.all(spacingXS),
            height: iconSize_28 * 2 + 8,
            width: iconSize_28 * 2 + 8,
            decoration: BoxDecoration(
                color: secondaryRed,
                borderRadius: BorderRadius.circular(radius_4)),
            child: const Icon(
              Icons.favorite_border,
              size: iconSize_28 * 2,
              color: primaryRed,
            ),
          ),
          TextView(
              margin: const EdgeInsets.only(top: spacingXXL6),
              title: getString('no_records_found'),
              textAlign: TextAlign.center,
              textStyle: quicksand_14ptBold(color: black),
              id: 'id'),
        ],
      ),
    );
  }
}
