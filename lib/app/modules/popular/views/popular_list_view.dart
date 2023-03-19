import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/core/values/app_colors.dart';
import 'package:manav_movies/app/modules/popular/controllers/popular_controller.dart';
import 'package:manav_movies/app/modules/popular/widget/popular_List_item_widget.dart';

import '../../../core/base/base_list_widget.dart';
import '../../../core/components/no_internet_widget.dart';
import '../../../data/model/movie/movies.dart';
import '../widget/popular_empty_widget.dart';
import '../widget/popular_error_widget.dart';
import '../widget/popular_shimmer_widget.dart';

class PopularListView extends BaseListGetWidget<PopularController, Movies> {
  const PopularListView({super.key});

  @override
  Widget getNoInternetWidget(BuildContext context, PopularController controller) {
    // TODO: implement getNoInternetWidget
    return const NoInternetScreen();
  }

  @override
  Widget getEmptyListWidget(BuildContext context, PopularController controller) {
    return const PopularEmptyView();
  }

  @override
  Widget getShimmerWidget(BuildContext context, PopularController controller) {
    // TODO: implement getShimmerWidget
    return const PopularShimmerWidget();
  }

  @override
  Widget getTopWidget(BuildContext context, PopularController controller) {
    return Container();
  }

  @override
  Widget getErrorWidget(BuildContext context, PopularController controller) {
    // TODO: implement getErrorWidget
    return PopularErrorWidget();
  }

  @override
  Widget getListItemWidget(BuildContext context, PopularController controller, Movies itemModel, int index) {
    return PopularListItem(index: index, itemModel: itemModel);
  }

  @override
  PopularController onInitialize() {
    return Get.find<PopularController>();
  }

  @override
  Color? getScreenColor() {
    return white_100;
  }

  @override
  void onLoadMore(BuildContext context, PopularController controller) {
    if (controller.getDataList().length < controller.popularListModel!.totalCount && !controller.isLoading()) {
      controller.setLoading(true);
      controller.fetchCards();
    }
  }

  @override
  Widget getLoadMoreWidget(BuildContext context, PopularController controller) {
    return Container();
  }

  @override
  void onScreenReady(BuildContext context, PopularController controller,
      ScrollController scrollController) {
    controller.fetchCards(reset: true);
  }
}
