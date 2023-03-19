import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../values/app_colors.dart';
import 'base_controller.dart';

abstract class BaseWidget<T extends BaseController> extends GetView<T> {

  BaseWidget({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _firstLaunch = true;

  @override
  Widget build(BuildContext context) {
    if (_firstLaunch) {
      _firstLaunch = false;
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        onScreenReady(context, controller);
      });
    }

    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: getToolBar(context)!=null ? getToolBar(context) as PreferredSizeWidget?: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: AppBar(
              backgroundColor: lightGrey,
              elevation: 0.0,
             systemOverlayStyle: SystemUiOverlayStyle.light,
            )),
        floatingActionButton: getFloatingButton(context),
        floatingActionButtonLocation: getFloatingActionButtonLocation(context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: getBuildWidget(context),
            ),
          ),
        ),
        backgroundColor: getScreenColor(),
        drawer: getDrawer(context),
        endDrawer: getEndDrawer(context),
        bottomNavigationBar: getBottomNavigationBar(context),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        endDrawerEnableOpenDragGesture: false,
        drawerEnableOpenDragGesture: false,
      ),
      onWillPop: () {
        performBack(context);
        return Future.value(false);
      },
    );
  }

  performBack(BuildContext context, {dynamic result}) {
    backPressedForTracking();

    if (overrideBackBehaviour()) {
      onBackPressManual();
    } else {
      if (Navigator.of(context).canPop()) {
        Get.back(result: result);
      } else {
        SystemNavigator.pop();
      }
    }
  }

  bool isDrawerOpen() {
    return _scaffoldKey.currentState!.isDrawerOpen;
  }

  openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  closeDrawer() {
    _scaffoldKey.currentState!.closeDrawer();
  }

  backPressedForTracking() {}

  bool overrideBackBehaviour() {
    return false;
  }

  void onBackPressManual() {}

  void onScreenReady(BuildContext context, T controller);

  //void onPreBuild(BuildContext context) {}

  Widget? getToolBar(BuildContext context) {
    return null;
  }

  Widget? getFloatingButton(BuildContext context) {
    return null;
  }

  FloatingActionButtonLocation getFloatingActionButtonLocation(BuildContext context) {
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

  bool showCobrowseSessionWidget() {
    return true;
  }

  Widget getBuildWidget(BuildContext context);

  Widget? getBottomNavigationBar(BuildContext context) {
    return null;
  }
}