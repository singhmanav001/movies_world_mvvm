import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manav_movies/app/core/values/app_colors.dart';
import 'package:manav_movies/app/data/model/movie/movies.dart';
import 'package:manav_movies/app/modules/top_rated/widget/top_rated_error_widget.dart';
import 'package:manav_movies/app/modules/top_rated/widget/top_rated_shimmer_widget.dart';

import '../../../core/base/base_list_widget.dart';
import '../../../core/components/no_internet_widget.dart';
import '../../../core/controllers/my_app_controller.dart';
import '../controllers/top_rated_controller.dart';
import '../widget/top_rated_List_item_widget.dart';
import '../widget/top_rated_empty_widget.dart';

class TopRatedListView extends BaseListGetWidget<TopRatedController, Movies> {
  final MyAppController myAppController = Get.find<MyAppController>();
  TopRatedListView({super.key});

  @override
  Widget getListItemWidget(BuildContext context, TopRatedController controller, itemModel, int index) {
    return TopRatedListItem(index: index, itemModel: itemModel);
  }

  @override
  Widget getNoInternetWidget(BuildContext context, TopRatedController controller) {
    // TODO: implement getNoInternetWidget
    return const NoInternetScreen();
  }

  @override
  Future<void> onLoadMore(BuildContext context, TopRatedController controller) async {
    if (controller.getDataList().length < controller.topRatedListModel!.totalCount && !controller.isLoading()) {
      controller.setLoading(true);
      controller.fetchCards();
    }
  }

  @override
  Widget getLoadMoreWidget(BuildContext context, TopRatedController controller) {
    return Container();
  }

  @override
  Widget getErrorWidget(BuildContext context, TopRatedController controller) {
    return const TopRatedErrorWidget();
  }

  @override
  Widget getShimmerWidget(BuildContext context, TopRatedController controller) {
    return const TopRatedShimmerWidget();
  }

  @override
  Widget getTopWidget(BuildContext context, TopRatedController controller) {
    return Container();
  }

  @override
  Color? getScreenColor() {
    return white_100;
  }

  @override
  TopRatedController onInitialize() {
    return Get.find<TopRatedController>();
  }

  @override
  Widget getEmptyListWidget(BuildContext context, TopRatedController controller) {
    return const TopRatedEmptyView();
  }

  @override
  void onScreenReady(BuildContext context, TopRatedController controller, ScrollController scrollController) {
    super.onScreenReady(context, controller, scrollController);
    controller.fetchCards(reset: true);
  }
}
