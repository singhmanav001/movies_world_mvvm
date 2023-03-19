import 'package:flutter/material.dart';

import '../../../core/base/base_shimmer_widget.dart';
import '../../../core/library/shimmer/shimmer.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/values/app_dimen.dart';

class TopRatedShimmerWidget extends BaseShimmerWidget {
  const TopRatedShimmerWidget({super.key});

  @override
  Widget getBuildWidget(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: List.generate(10, (index) => _getShimmerTileB()),
    ));
  }

  Widget _getShimmerTileB() {
    return Container(
      margin: const EdgeInsets.only(
          top: smallMargin, bottom: smallMargin, left: margin, right: margin),
      padding: const EdgeInsets.only(
          top: margin, bottom: margin, left: margin, right: margin),
      decoration: BoxDecoration(
        color: white_100,
        borderRadius: BorderRadius.circular(radius_8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highLightColor,
                period: time,
                child: Container(
                  width: 2 * radius_24,
                  height: 2 * radius_24,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(radius_8)),
                    color: baseColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highLightColor,
                        period: time,
                        child: Container(
                          height: radius_12,
                          decoration: BoxDecoration(
                            color: baseColor,
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highLightColor,
                        period: time,
                        child: Container(
                          margin: const EdgeInsets.only(top: margin_12),
                          height: radius_12,
                          decoration: BoxDecoration(
                            color: baseColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highLightColor,
            period: time,
            child: Container(
              margin: const EdgeInsets.only(top: margin_12),
              height: radius_12,
              decoration: BoxDecoration(
                color: baseColor,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highLightColor,
            period: time,
            child: Container(
              margin: const EdgeInsets.only(top: margin_6),
              height: radius_12,
              decoration: BoxDecoration(
                color: baseColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
