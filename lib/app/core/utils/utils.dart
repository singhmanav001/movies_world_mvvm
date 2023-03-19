import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../modules/main/model/menu_code.dart';
import '../components/custom_snack_bar.dart';
import '../values/app_colors.dart';
String getSvg(String name) {
  return "images/svg/$name.svg";
}

String getPng(String name) {
  return "images/png/$name.png";
}
String getJpg(String name) {
  return "images/$name.jpg";
}
String getString(String tag,
    {String? plural, int length = 0, Map<String, String>? params}) {
  if (plural != null) {
    if (params != null) {
      return tag.trPluralParams(plural, length, params);
    }
    return tag.trPlural(plural, length);
  }
  if (params != null) {
    return tag.trParams(params);
  }
  return tag.tr;
}

appLog(dynamic message) {
  log(message);
}

bool nonNullNotEmpty(dynamic value) {
  if (value != null) {
    if (value is List || value is Map) return value.length > 0;
    if (value is String) return value.isNotEmpty;
    if (value is int || value is double) return value != 0;
  }
  return false;
}

String getMapCheckedString(Map? map, String key, {String defaultValue = ''}) {
  try {
    return map != null && map.containsKey(key)
        ? map[key] != null
            ? map[key].toString().toLowerCase() != 'null'
                ? map[key].toString()
                : defaultValue
            : defaultValue
        : defaultValue;
  } catch (e) {
    return defaultValue;
  }
}

dynamic getMapCheckedValue(Map? map, String key, dynamic defaultValue) {
  try {
    return map != null && map.containsKey(key)
        ? map[key] ?? defaultValue
        : defaultValue;
  } catch (e) {
    return defaultValue;
  }
}

bool getMapCheckedBool(Map? map, String key, {bool defaultValue = false}) {
  try {
    if (map != null && map.containsKey(key) && map[key] != null) {
      return map[key].toString().toLowerCase() == 'true';
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

List<String> getMapCheckedStringList(Map? map, String key,
    {List<String> defaultValue = const <String>[]}) {
  try {
    if (map != null && map.containsKey(key) && map[key] != null) {
      String value = map[key].toString().replaceAll('[', '').replaceAll(']', '').trim();
      return value.split(', ');
      //return json.decode(value);
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

List<String> getMapDoubleCheckedStringList(
    Map? map, String innerMapKey, String key,
    {List<String> defaultValue = const <String>[]}) {
  try {
    if (map != null &&
        map.containsKey(innerMapKey) &&
        map[innerMapKey] != null &&
        map[innerMapKey] is Map<String, dynamic>) {
      Map? innerMap = map[innerMapKey];
      if (innerMap != null &&
          innerMap.containsKey(key) &&
          innerMap[key] != null) {
        String value = innerMap[key]
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .trim();
        //return json.decode(value);
        return value.split(', ');
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

Map<String, dynamic> getMapCheckedMap(Map? map, String key) {
  try {
    Map<String, dynamic> rMap;
    if (map != null &&
        map.containsKey(key) &&
        map[key] != null &&
        map[key] is Map<String, dynamic>) {
      rMap = map[key];
    } else {
      rMap = <String, dynamic>{};
    }
    return rMap;
  } catch (e) {
    appLog(e);
  }
  return <String, dynamic>{};
}

Map<String, dynamic> getMapDoubleCheckedMap(
    Map? map, String innerMapKey, String key) {
  try {
    if (map != null &&
        map.containsKey(innerMapKey) &&
        map[innerMapKey] != null &&
        map[innerMapKey] is Map<String, dynamic>) {
      Map? innerMap = map[innerMapKey];
      if (innerMap != null &&
          innerMap.containsKey(key) &&
          innerMap[key] != null &&
          innerMap[key] is Map<String, dynamic>) {
        return innerMap[key] ?? <String, dynamic>{};
      } else {
        return <String, dynamic>{};
      }
    } else {
      return <String, dynamic>{};
    }
  } catch (e) {
    return <String, dynamic>{};
  }
}

double getMapCheckedDouble(Map? map, String key, {double defaultValue = 0}) {
  try {
    if (map != null && map.containsKey(key) && map[key] != null) {
      var d = map[key];
      return double.parse(d.toString());
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

int getMapCheckedInt(Map? map, String key, {int defaultValue = 0}) {
  try {
    if (map != null && map.containsKey(key) && map[key] != null) {
      var d = map[key];
      return double.parse(d.toString()).toInt();
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

int typeCastToInt(String value) {
  int rValue = 0;
  try {
    rValue = int.parse(value);
  } catch (e) {
    appLog(e);
    rValue = 0;
  }
  return rValue;
}

dynamic getMapDoubleCheckedValue(
    Map? map, String innerMapKey, String key, dynamic defaultValue) {
  try {
    dynamic valueReturn;
    if (map != null && map.containsKey(innerMapKey)) {
      Map? innerMap = map[innerMapKey];
      if (innerMap != null && innerMap.containsKey(key)) {
        valueReturn = innerMap[key] ?? defaultValue;
      } else {
        valueReturn = defaultValue;
      }
    } else {
      valueReturn = defaultValue;
    }

    return valueReturn;
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

int getMapDoubleCheckedInt(Map? map, String innerMapKey, String key,
    {int defaultValue = 0}) {
  try {
    if (map != null &&
        map.containsKey(innerMapKey) &&
        map[innerMapKey] != null) {
      Map? innerMap = map[innerMapKey];
      if (innerMap != null &&
          innerMap.containsKey(key) &&
          innerMap[key] != null) {
        var d = innerMap[key];
        return double.parse(d.toString()).toInt();
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

double getMapDoubleCheckedDouble(Map? map, String innerMapKey, String key,
    {double defaultValue = 0}) {
  try {
    if (map != null &&
        map.containsKey(innerMapKey) &&
        map[innerMapKey] != null) {
      Map? innerMap = map[innerMapKey];
      if (innerMap != null &&
          innerMap.containsKey(key) &&
          innerMap[key] != null) {
        var d = innerMap[key];
        return double.parse(d.toString());
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

bool getMapDoubleCheckedBool(Map? map, String innerMapKey, String key,
    {bool defaultValue = false}) {
  try {
    if (map != null &&
        map.containsKey(innerMapKey) &&
        map[innerMapKey] != null) {
      Map? innerMap = map[innerMapKey];
      if (innerMap != null &&
          innerMap.containsKey(key) &&
          innerMap[key] != null) {
        return innerMap[key].toString().toLowerCase() == 'true';
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

dynamic getMapTripleCheckedValue(
    Map? mainMap, String key1, String key2, String key, dynamic defaultValue) {
  try {
    dynamic valueReturn;
    if (mainMap != null && mainMap.containsKey(key1) && mainMap[key1] != null) {
      Map? firstMap = mainMap[key1];
      if (firstMap != null &&
          firstMap.containsKey(key2) &&
          firstMap[key2] != null) {
        Map? secondMap = firstMap[key2];
        if (secondMap != null &&
            secondMap.containsKey(key) &&
            secondMap[key] != null) {
          valueReturn = secondMap[key] ?? defaultValue;
        } else {
          valueReturn = defaultValue;
        }
      } else {
        valueReturn = defaultValue;
      }
    } else {
      valueReturn = defaultValue;
    }

    return valueReturn;
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

Map<String, dynamic> getMapTripleCheckedMap(
    Map? mainMap, String key1, String key2, String key) {
  try {
    if (mainMap != null &&
        mainMap.containsKey(key1) &&
        mainMap[key1] != null &&
        mainMap[key1] is Map<String, dynamic>) {
      Map<String, dynamic>? firstMap = mainMap[key1];
      if (firstMap != null &&
          firstMap.containsKey(key2) &&
          firstMap[key2] != null &&
          firstMap[key2] is Map<String, dynamic>) {
        Map<String, dynamic>? secondMap = firstMap[key2];
        if (secondMap != null &&
            secondMap.containsKey(key) &&
            secondMap[key] != null &&
            secondMap[key] is Map<String, dynamic>) {
          return secondMap[key];
        } else {
          return <String, dynamic>{};
        }
      } else {
        return <String, dynamic>{};
      }
    } else {
      return <String, dynamic>{};
    }
  } catch (e) {
    appLog(e);
    return <String, dynamic>{};
  }
}

int getMapTripleCheckedInt(Map? mainMap, String key1, String key2, String key,
    {int defaultValue = 0}) {
  try {
    if (mainMap != null && mainMap.containsKey(key1) && mainMap[key1] != null) {
      Map? firstMap = mainMap[key1];
      if (firstMap != null &&
          firstMap.containsKey(key2) &&
          firstMap[key2] != null) {
        Map? secondMap = firstMap[key2];
        if (secondMap != null &&
            secondMap.containsKey(key) &&
            secondMap[key] != null) {
          var d = secondMap[key];
          return double.parse(d.toString()).toInt();
        } else {
          return defaultValue;
        }
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

double getMapTripleCheckedDouble(
    Map? mainMap, String key1, String key2, String key,
    {double defaultValue = 0}) {
  try {
    if (mainMap != null && mainMap.containsKey(key1) && mainMap[key1] != null) {
      Map? firstMap = mainMap[key1];
      if (firstMap != null &&
          firstMap.containsKey(key2) &&
          firstMap[key2] != null) {
        Map? secondMap = firstMap[key2];
        if (secondMap != null &&
            secondMap.containsKey(key) &&
            secondMap[key] != null) {
          var d = secondMap[key];
          return double.parse(d.toString());
        } else {
          return defaultValue;
        }
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

bool getMapTripleCheckedBool(Map? mainMap, String key1, String key2, String key,
    {bool defaultValue = false}) {
  try {
    if (mainMap != null && mainMap.containsKey(key1) && mainMap[key1] != null) {
      Map? firstMap = mainMap[key1];
      if (firstMap != null &&
          firstMap.containsKey(key2) &&
          firstMap[key2] != null) {
        Map? secondMap = firstMap[key2];
        if (secondMap != null &&
            secondMap.containsKey(key) &&
            secondMap[key] != null) {
          return secondMap[key].toString().toLowerCase() == 'true';
        } else {
          return defaultValue;
        }
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

String getMapDoubleCheckedString(Map? map, String key1, String key2,
    {String defaultValue = ''}) {
  try {
    if (map != null && map.containsKey(key1) && map[key1] != null) {
      Map? innerMap = map[key1];
      if (innerMap != null &&
          innerMap.containsKey(key2) &&
          innerMap[key2] != null) {
        return innerMap[key2].toString().toLowerCase() != 'null'
            ? innerMap[key2].toString()
            : defaultValue;
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

String getMapTripleCheckedString(
    Map? mainMap, String key1, String key2, String key,
    {String defaultValue = ''}) {
  try {
    if (mainMap != null && mainMap.containsKey(key1) && mainMap[key1] != null) {
      Map? firstMap = mainMap[key1];
      if (firstMap != null &&
          firstMap.containsKey(key2) &&
          firstMap[key2] != null) {
        Map? secondMap = firstMap[key2];
        if (secondMap != null &&
            secondMap.containsKey(key) &&
            secondMap[key] != null) {
          return secondMap[key].toString().toLowerCase() != 'null'
              ? secondMap[key].toString()
              : defaultValue;
        } else {
          return defaultValue;
        }
      } else {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  } catch (e) {
    appLog(e);
    return defaultValue;
  }
}

Color stringToColor(String colorString, Color defaultColor) {
  if (colorString.isNotEmpty) {
    var hexColor = colorString.replaceAll("#", "").replaceAll('0x', "").trim();
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      try {
        return Color(int.parse("0x$hexColor"));
      } catch (e) {
        appLog(e);
        return defaultColor;
      }
    } else {
      return defaultColor;
    }
  } else {
    return defaultColor;
  }
}

MenuCode getMenuCode(String id) {
  switch (id) {
    case "popular":
      return MenuCode.POPULAR;
    case "top_rated":
      return MenuCode.TOP_RATED;
    default:
      return MenuCode.OTHER;
  }
}

void portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void statusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: appBarColor, statusBarBrightness: Brightness.light),
  );
}

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
showToast(
    String? message, {
      Toast length = Toast.LENGTH_SHORT,
      ToastGravity gravity = ToastGravity.BOTTOM,
      Color backgroundColor = Colors.black,
      Color textColor = Colors.white,
      int timeInSecForIosWeb = 1,
      bool showAsSnackBar = true,
      Color snackBarColorBackground = Colors.black,
      Color snackBarTopColor = primaryRed,
      EdgeInsets? margin,
    }) {
  if (showAsSnackBar) {
    showGetSnackBar(message ?? '', snackBarColorBackground: snackBarColorBackground, snackBarTopColor: snackBarTopColor, margin: margin);
    return;
  }
  try {
    Fluttertoast.cancel();
  } catch (e) {
    appLog(e);
  }
  Fluttertoast.showToast(
      msg: message ?? '', toastLength: length, gravity: gravity, backgroundColor: backgroundColor, textColor: textColor, timeInSecForIosWeb: timeInSecForIosWeb, fontSize: 16.0);
}
showGetSnackBar(String message,
    {Color snackBarColorBackground = Colors.black,
      Color snackBarTopColor = primaryRed,
      Color snackTextColor = white_100,
      EdgeInsets? margin,
      bool showCrossBtn = true,
      bool enableOverride = false}) async {
  Duration snackBarDuration = const Duration(seconds: 3);
  GetSnackBar getBar = GetSnackBar(
      duration: snackBarDuration,
      animationDuration: const Duration(milliseconds: 300),
      snackbarStatus: (SnackbarStatus? status) {
        if (status == SnackbarStatus.OPENING || status == SnackbarStatus.CLOSED) {}
        appLog("status ------> $status");
      },
      messageText: CustomSnackBar(
        message: message,
        snackBarColorBackground: snackBarColorBackground,
        snackBarTopColor: snackBarTopColor,
        snackBarTextColor: snackTextColor,
        showCrossBtn: showCrossBtn,
      ),
      margin: margin ??
          const EdgeInsets.all(
            0,
          ),
      padding: const EdgeInsets.all(0));

  if (enableOverride) {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
      getBar.show();
    } else {
      getBar.show();
    }
  } else if (!Get.isSnackbarOpen) {
    getBar.show();
  }
}
bool isUrlCorrect(String? imagePath) {
  if (imagePath != null && imagePath.isNotEmpty) {
    bool validURL = Uri.parse(imagePath).isAbsolute;
    return validURL;
  }
  return false;
}

