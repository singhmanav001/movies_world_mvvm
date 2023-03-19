import 'app_secret/app_secret_config.dart';
import 'package:flutter/material.dart';
import 'app/core/utils/utils.dart';
import 'app/my_app.dart';
import 'dart:async';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    AppSecretConfig.instantiate(
      values: AppSecretValues(
        baseUrl: 'https://api.themoviedb.org/3/',
        apiKey: '909594533c98883408adef5d56143539',
      ),
    );
    runApp(const MyApp());
  }, (exception, stackTrace) async {
    appLog("exception in zone added");
  });
}
