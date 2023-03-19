import 'package:get/get.dart';
import 'package:manav_movies/app/core/values/app_constants.dart';
import 'package:manav_movies/app/modules/top_rated/model/top_rated_model.dart';

import '../../../core/base/base_list_controller.dart';
import '../../../core/base/base_model.dart';
import '../../../core/enum/enums.dart';
import '../../../core/utils/utils.dart';
import '../../../data/model/movie/movies.dart';
import '../../../data/repository/top_rated/top_rated_repo.dart';

class TopRatedController extends BaseListController<Movies> {
  final TopRatedRepo topRatedListRepo = Get.find(tag: (TopRatedRepo).toString());
  TopRatedModel? topRatedListModel;
  int page = 1;

  Future<void> fetchCards({bool reset = false}) async {
    if (await isConnected()) {
      if (reset) {
        viewState.value = ViewState.SHIMMER_STATE;
        getDataList().clear();
      }
      try {
        topRatedListModel = await topRatedListRepo.getTopRatedMovieListData(page, AppEndpoints.topRated);
        if (topRatedListModel?.responseState == ResponseState.SUCCESS) {
          if (topRatedListModel?.listTopRatedList == null && getDataList().isEmpty) {
            viewState.value = ViewState.LIST_EMPTY_STATE;
          } else {
            if (page == 1) {
              page++;
              setLoading(false);
              clearDataList();
              addItemsToDataList(topRatedListModel?.listTopRatedList, clearPreviousData: reset);
              viewState.value = ViewState.LIST_VIEW_STATE;
            }else {
              page++;
              setLoading(false);
              addItemsToDataList(topRatedListModel?.listTopRatedList, clearPreviousData: reset);
              viewState.value = ViewState.LIST_VIEW_STATE;
            }
          }
        } else if (getDataList().isEmpty) {
          viewState.value = ViewState.LIST_ERROR_STATE;
          showToast(topRatedListModel?.uiMessage ?? getString("something_went_wrong"));
        }
      } catch (e) {
        if (getDataList().isEmpty) {
          viewState.value = ViewState.LIST_ERROR_STATE;
        }
        appLog(e);
      }
    } else {
      showToast(getString('no_internet_message'));
      if (getDataList().isEmpty) {
        viewState.value = ViewState.NO_INTERNET_STATE;
      }
    }
  }
}
