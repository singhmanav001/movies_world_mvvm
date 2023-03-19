import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../enum/enums.dart';
import '../library/pull_to_refresh/indicator/custom_indicator.dart';
import '../library/pull_to_refresh/smart_refresher.dart';
import '../utils/utils.dart';
import '../values/app_colors.dart';
import 'base_list_controller.dart';

abstract class BaseListGetWidget<T extends BaseListController, V>
    extends StatefulWidget {
  const BaseListGetWidget({super.key});

  T onInitialize();

  Widget getListSeparatorWidget(
      BuildContext context, T controller, V itemModel, int index) {
    return Container();
  }

  Widget getListItemWidget(
      BuildContext context, T controller, V itemModel, int index);

  performBack(BuildContext context, {dynamic result}) {
    backPressedForTracking();
    if (overrideBackBehaviour()) {
      onBackPressManual(context);
    } else {
      if (Navigator.of(context).canPop()) {
        Get.back(result: result);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  bool overrideBackBehaviour() {
    return false;
  }

  void onBackPressManual(BuildContext context) {}

  void onScreenReady(
      BuildContext context, T controller, ScrollController scrollController) {}

  void onConnected(BuildContext context, T controller) {}

  void onDisConnected(BuildContext context, T controller) {}

  void onLoadMore(BuildContext context, T controller) {}

  void onPreBuild(BuildContext context, T controller) {}

  void onListScrollToTop(BuildContext context, T controller) {}

  void onListScroll(BuildContext context, ListScrollEnum scrollEnum,
      T controller, double pixels) {}

  void onListScrollStart(BuildContext context, T controller) {}

  void onListScrollEnd(BuildContext context, T controller) {}

  Widget getShimmerWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget? getUnaffectedTopWidget(BuildContext context, T controller) {
    return null;
  }

  Widget getLoadMoreWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getNoInternetWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getBottomWidget(BuildContext context, T controller) {
    return Container();
  }

  String? getControllerTagName() {
    return null;
  }

  Widget getTopWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getErrorWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget getEmptyListWidget(BuildContext context, T controller) {
    return Container();
  }

  Widget? getToolBar(BuildContext context, T controller) {
    return null;
  }

  Widget? getFloatingButton(BuildContext context, T controller) {
    return null;
  }

  Widget? getBottomNavigationBar(BuildContext context) {
    return null;
  }

  FloatingActionButtonLocation getFloatingActionButtonLocation(
      BuildContext context) {
    return FloatingActionButtonLocation.endFloat;
  }

  Color? getScreenColor() {
    return null;
  }

  Drawer? getDrawer(BuildContext context) {
    return null;
  }

  Drawer? getEndDrawer(BuildContext context) {
    return null;
  }

  bool resizeToAvoidBottomInset() {
    return true;
  }

  bool applyDefaultAnimationForFAB() {
    return true;
  }

  bool scrollToTopOnFirstBack() {
    return true;
  }

  bool isControllerGlobal() {
    return true;
  }

  double cacheExtentLimit() {
    return 20;
  }

  bool enablePullToRefresh(T controller) {
    return false;
  }

  Widget? pullToRefreshHeader() => null;

  void onPullToRefresh(T controller) {}

  backPressedForTracking() {}

  void showAppBottomSheet(
    Widget child, {
    Function? onBottomSheetClosed,
    Color barrierColor = Colors.black54,
    bool closeOnOutsideClick = true,
    ShapeBorder? shape,
  }) {
    Get.bottomSheet(
      child,
      barrierColor: barrierColor,
      isDismissible: closeOnOutsideClick,
      shape: shape,
    ).then((value) {
      if (onBottomSheetClosed != null) {
        Future.delayed(const Duration(milliseconds: 250), () {
          onBottomSheetClosed();
        });
      }
    });
  }

  @override
  State<StatefulWidget> createState() {
    return _BaseListGetWidgetState<T, V>();
  }
}

class _BaseListGetWidgetState<T extends BaseListController?, V>
    extends State<BaseListGetWidget> with SingleTickerProviderStateMixin {
  var _getController;
  bool _firstLaunch = true;
  bool _firstTimeNet = true;
  final ScrollController _scrollController = ScrollController();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  PreviousNetStatus _previousNetStatus = PreviousNetStatus.NONE;
  late Animation<Offset> _offset;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _getController = widget.onInitialize();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 2.0))
        .animate(_animationController!);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onScreenReady(context, _getController, _scrollController);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!_getController.isLoading()) {
          widget.onLoadMore(context, _getController);
        }
      } else if (_scrollController.position.pixels == 0) {
        widget.onListScrollToTop(context, _getController);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (widget.applyDefaultAnimationForFAB()) {
          _animationController?.forward();
        }
        widget.onListScroll(context, ListScrollEnum.UP, _getController,
            _scrollController.position.pixels);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (widget.applyDefaultAnimationForFAB()) {
          _animationController?.forward();
        }
        widget.onListScroll(context, ListScrollEnum.DOWN, _getController,
            _scrollController.position.pixels);
      }
      if (widget.applyDefaultAnimationForFAB()) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          try {
            _animationController?.reverse();
          } catch (e) {
            appLog(e);
          }
        });
      }
    });

    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      appLog(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult? result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            widget.onConnected(context, _getController);
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
            widget.onConnected(context, _getController);
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
            widget.onDisConnected(context, _getController);
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
            widget.onDisConnected(context, _getController);
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _connectivitySubscription?.cancel();
    if (widget.getControllerTagName() != null &&
        widget.getControllerTagName()!.isNotEmpty) {
      Get.delete<T>(force: true, tag: widget.getControllerTagName());
    } else {
      Get.delete<T>(force: true);
    }
    super.dispose();
  }

  bool showCobrowseSessionWidget() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_firstLaunch) {
      _firstLaunch = false;
      widget.onPreBuild(context, _getController);
    }
    return GetBuilder<GetxController>(
      init: _getController,
      global: widget.isControllerGlobal(),
      builder: (lc) {
        return WillPopScope(
          //Remove this widget if app require notch display.
          child: Scaffold(
            appBar: widget.getToolBar(context, _getController) != null
                ? widget.getToolBar(context, _getController)
                    as PreferredSizeWidget?
                : PreferredSize(
                    preferredSize: const Size.fromHeight(0.0),
                    child: AppBar(
                      backgroundColor: lightGrey,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                    )),
            floatingActionButton:
                widget.getFloatingButton(context, _getController) != null
                    ? widget.applyDefaultAnimationForFAB()
                        ? Obx(() {
                            return !_getController.showLoadMore.value &&
                                    _getController.viewState.value ==
                                        ViewState.LIST_VIEW_STATE
                                ? SlideTransition(
                                    position: _offset,
                                    child: widget.getFloatingButton(
                                        context, _getController),
                                  )
                                : Container();
                          })
                        : widget.getFloatingButton(context, _getController)
                    : null,
            floatingActionButtonLocation:
                widget.getFloatingActionButtonLocation(context),
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: getContentArea(),
              ),
            ),
            backgroundColor: widget.getScreenColor(),
            drawer: widget.getDrawer(context),
            endDrawer: widget.getEndDrawer(context),
            bottomNavigationBar: widget.getBottomNavigationBar(context),
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset(),
            endDrawerEnableOpenDragGesture: false,
            drawerEnableOpenDragGesture: false,
          ),
          onWillPop: () {
            if (widget.scrollToTopOnFirstBack()) {
              if (_scrollController.hasClients &&
                  _scrollController.position.pixels != 0) {
                _getController.scrollToTop(_scrollController);
              } else {
                widget.performBack(context);
              }
            } else {
              widget.performBack(context);
            }
            return Future.value(false);
          },
        );
      },
    );
  }

  Widget getContentArea() {
    if (widget.getUnaffectedTopWidget(context, _getController) != null) {
      return Column(
        children: [
          widget.getUnaffectedTopWidget(context, _getController)!,
          Expanded(child: Obx(() {
            return _viewWidget(context, _getController);
          })),
        ],
      );
    }
    return Obx(() {
      return _viewWidget(context, _getController);
    });
  }

  Widget _viewWidget(BuildContext context, T lc) {
    switch (lc!.viewState.value) {
      case ViewState.SHIMMER_STATE:
        return widget.getShimmerWidget(context, lc);
      case ViewState.NO_INTERNET_STATE:
        return widget.getNoInternetWidget(context, lc);
      case ViewState.LIST_ERROR_STATE:
        return widget.getErrorWidget(context, lc);
      case ViewState.LIST_EMPTY_STATE:
        return widget.getEmptyListWidget(context, lc);
      case ViewState.LIST_VIEW_STATE:
        return _getListViewWidget(
            context, lc, lc.getDataList().toList() as List<V>);
      default:
        return Container();
    }
  }

  Widget _getListViewWidget(
      BuildContext context, T controller, List<V>? dataList) {
    if (dataList != null) {
      if (dataList.isNotEmpty) {
        return Column(
          children: [
            widget.getTopWidget(context, controller!),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    widget.onListScrollStart(context, _getController);
                  } else if (scrollNotification is ScrollUpdateNotification) {
                  } else if (scrollNotification is ScrollEndNotification) {
                    widget.onListScrollEnd(context, _getController);
                  }
                  return true;
                },
                child: widget.enablePullToRefresh(controller)
                    ? SmartRefresher(
                        controller: controller.refreshController,
                        enablePullUp: true,
                        enablePullDown: widget.enablePullToRefresh(controller),
                        header: widget.pullToRefreshHeader(),
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            return const SizedBox(
                              height: 0,
                              width: 0,
                            );
                          },
                          height: 0,
                        ),
                        onRefresh: () {
                          widget.onPullToRefresh(controller);
                        },
                        child: _getListWidget(context, controller, dataList),
                      )
                    : _getListWidget(context, controller, dataList),
              ),
            ),
            widget.getBottomWidget(context, controller),
          ],
        );
      } else {
        return widget.getEmptyListWidget(context, controller!);
      }
    } else {
      return widget.getErrorWidget(context, controller!);
    }
  }

  Widget _getListWidget(BuildContext context, T controller, List<V> dataList) {
    return ListView.separated(
      itemBuilder: (ctx, index) {
        return index == dataList.length
            ? Obx(() {
                if ((controller as BaseListController).isLoading()) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  });
                  return widget.getLoadMoreWidget(context, controller);
                } else {
                  return Container();
                }
              })
            : widget.getListItemWidget(
                context,
                controller as BaseListController,
                dataList.elementAt(index),
                index);
      },
      separatorBuilder: (ctx, index) {
        return widget.getListSeparatorWidget(context,
            controller as BaseListController, dataList.elementAt(index), index);
      },
      itemCount: dataList.isNotEmpty ? dataList.length + 1 : 0,
      shrinkWrap: true,
      cacheExtent: widget.cacheExtentLimit(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      scrollDirection: Axis.vertical,
      controller: _scrollController,
    );
  }
}
