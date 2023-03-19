// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'bindings/initial_binding.dart';
import 'core/controllers/my_app_controller.dart';
import 'core/utils/utils.dart';
import 'core/values/app_colors.dart';
import 'core/values/app_constants.dart';
import 'locale/localization.dart';
import 'routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    statusBarColor();
    portraitModeOnly();
    Get.put(MyAppController());
    Get.put(Localization(),permanent: true);
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      appLog("CRASH ===> 1 $errorDetails");
    };
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            GetMaterialApp(
              initialRoute: AppPages.INITIAL,
              translationsKeys: Get
                  .find<Localization>()
                  .keys,
              translations: Get.find<Localization>(),
              locale: const Locale(AppConstants.defaultLanguageCode, 'IN'),
              fallbackLocale: const Locale('en', 'IN'),
              initialBinding: InitialBinding(),
              getPages: AppPages.routes,
              navigatorKey: Get.key,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'IN'),
              ],
              theme: ThemeData(
                primarySwatch: colorPrimarySwatch,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: Brightness.light,
                primaryColor: colorPrimary,
                textTheme: const TextTheme(
                  button: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                fontFamily: 'Quicksand',
              ),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ResponsiveWrapper.builder(
                    BouncingScrollWrapper.builder(context, child!),
                    maxWidth: 640,
                    minWidth: 450,
                    defaultScale: true,
                    breakpoints: [
                      const ResponsiveBreakpoint.resize(450, name: MOBILE),
                      const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                      const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                      const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                    ],
                    background: Container(color: const Color(0xFFF5F5F5)));
              },
            ),
            GetBuilder<MyAppController>(
              builder: (lc) {
                return Stack(
                  children: [
                    Obx(() {
                      return lc.showGlobalProgress.value
                          ? Container(
                        width: Get.width,
                        height: Get.height,
                        alignment: Alignment.center,
                        color: overlay_32,
                        child: const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                          : Container();
                    }),
                  ],
                );
              },
            ),
          ],
        ));
  }
}
