import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/data/model/movie/movies.dart';
import 'package:manav_movies/app/modules/popular/controllers/popular_controller.dart';

import '../../../core/base/base_widget_mixin.dart';
import '../../../core/components/custom_ink_well.dart';
import '../../../core/components/text_view.dart';
import '../../../core/components/universal_media_view.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_dimen.dart';
import '../../../core/values/semantic_id.dart';
import '../../../core/values/text_styles.dart';

class PopularListItem extends StatelessWidget with BaseWidgetMixin {
  final PopularController controller = Get.find<PopularController>();
  final Movies itemModel;
  final int index;

  PopularListItem({required this.index, required this.itemModel, Key? key})
      : super(key: key);

  @override
  Widget body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: margin_8, bottom: margin_8, left: margin_16, right: margin_16),
      decoration: BoxDecoration(color: white_100, borderRadius: BorderRadius.circular(8), border: Border.all(color: borderColor)),
      child: CustomInkWell(
        id: 'popular_item_${itemModel.id}',
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(smallMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UniversalMediaView(
                    path: itemModel.posterPath,
                    id: SemanticsIds.imageId,
                    imageHeight: iconSize_56,
                    imageWidth: iconSize_56,
                    isClickable: false,
                    borderRadius: BorderRadius.circular(radius_8),
                    placeHolder: UniversalMediaView(
                      path: '',
                      id: SemanticsIds.imageId,
                      imageHeight: iconSize_56,
                      imageWidth: iconSize_56,
                      isClickable: false,
                      fit: BoxFit.contain,
                      borderRadius: BorderRadius.circular(radius_8),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: spacingM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                              title: itemModel.title,
                              textStyle: quicksand_16ptBold(color: black),
                              id: SemanticsIds.itemTitle),
                          TextView(
                            title: itemModel.releaseDate.toString(),
                            textStyle: quicksand_14ptRegular(color: lightGrey),
                            id: SemanticsIds.itemSubTitle,
                            margin: const EdgeInsets.only(top: margin_6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
