//region Description
// This is the main class for the development environment
//endregion

import 'package:ceylife_digital/core/ceylife_digital_app.dart';
import 'package:ceylife_digital/core/service/dependency_injection.dart' as di;
import 'package:ceylife_digital/utils/enums.dart';
import 'package:ceylife_digital/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'flavor_config.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.amber,
      values:
          FlavorValues(baseUrl: 'http://124.43.16.185:50189/cli-dev/api/v1/'));
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  StringUtils.getApplicationVersion();
  await di.setupLocator();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: CeylifeDigitalApp(),
      onPanDown: (_) {},
    ),
  );
}
