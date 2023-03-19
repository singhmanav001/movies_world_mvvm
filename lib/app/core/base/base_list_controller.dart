import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../enum/enums.dart';
import '../library/pull_to_refresh/smart_refresher.dart';
import '../utils/utils.dart';
import 'base_controller.dart';

abstract class BaseListController<T> extends BaseController {
  Rx<ViewState> viewState = ViewState.SHIMMER_STATE.obs;
  final RxList<T> _dataList = <T>[].obs;
  RxBool showLoadMore = false.obs;
  final Connectivity _connectivity = Connectivity();
  PreviousNetStatus _previousNetStatus = PreviousNetStatus.NONE;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _firstTimeNet = true;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  hidePullToRefreshBar() {
    try {
      refreshController.refreshCompleted();
    } catch (e) {
      appLog(e);
    }
  }

  bool isLoading() {
    return showLoadMore.value;
  }

  void setLoading(bool loading) {
    showLoadMore.value = loading;
  }

  void addItemsToDataList(List<T>? items, {bool clearPreviousData = false, Function? onDone}) {
    if (clearPreviousData) {
      _dataList.clear();
      _dataList.addAll(items!);
      if (onDone != null) {
        onDone();
      }
    } else {
      _dataList.addAll(items!);
      if (onDone != null) {
        onDone();
      }
    }
    showLoadMore.value = false;
  }

  void addItemToDataList(T item) {
    _dataList.add(item);
  }

  List<T> getDataList() {
    return _dataList;
  }

  void clearDataList() {
    _dataList.clear();
  }

  @override
  void onInit() {
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void onConnected() {}

  void onDisConnected() {}

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      appLog(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult? result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            onConnected();
          }
          _previousNetStatus = PreviousNetStatus.CONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.CONNECTED;
          _firstTimeNet = false;
        }
        break;
      case ConnectivityResult.mobile:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            onConnected();
          }
          _previousNetStatus = PreviousNetStatus.CONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.CONNECTED;
          _firstTimeNet = false;
        }
        break;
      case ConnectivityResult.none:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.DISCONNECTED) {
            onDisConnected();
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
      default:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.DISCONNECTED) {
            onDisConnected();
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
    }
  }
}
