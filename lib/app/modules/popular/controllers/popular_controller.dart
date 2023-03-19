import 'package:get/get.dart';
import 'package:manav_movies/app/core/values/app_constants.dart';
import 'package:manav_movies/app/data/repository/popular/popular_repo.dart';

import '../../../core/base/base_list_controller.dart';
import '../../../core/base/base_model.dart';
import '../../../core/enum/enums.dart';
import '../../../core/utils/utils.dart';
import '../../../data/model/movie/movies.dart';
import '../model/popular_model.dart';

class PopularController extends BaseListController<Movies> {
  final PopularListRepo popularListRepo = Get.find(tag: (PopularListRepo).toString());
  PopularModel? popularListModel;
  int page = 1;

  Future<void> fetchCards({bool reset = false}) async {
    if (await isConnected()) {
      if (reset) {
        page = 1;
        viewState.value = ViewState.SHIMMER_STATE;
        getDataList().clear();
      }
      try {
        popularListModel = await popularListRepo.getPopularMovieListData(page, AppEndpoints.popular);
        if (popularListModel?.responseState == ResponseState.SUCCESS) {
          if (popularListModel?.listPopularList == null && getDataList().isEmpty) {
            viewState.value = ViewState.LIST_EMPTY_STATE;
          } else {
            if (page == 1) {
                page++;
              setLoading(false);
              clearDataList();
                addItemsToDataList(popularListModel?.listPopularList, clearPreviousData: reset);
                viewState.value = ViewState.LIST_VIEW_STATE;
            }else {
              page++;
              setLoading(false);
              addItemsToDataList(popularListModel?.listPopularList, clearPreviousData: reset);
              viewState.value = ViewState.LIST_VIEW_STATE;
            }
          }
        } else if (getDataList().isEmpty) {
          viewState.value = ViewState.LIST_ERROR_STATE;
          showToast(popularListModel?.uiMessage ?? getString("something_went_wrong"));
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
