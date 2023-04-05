import 'package:ceylife_digital/features/presentation/common/app_data_provider.dart';
import 'package:ceylife_digital/features/presentation/views/app_builder.dart';
import 'package:ceylife_digital/utils/app_colors.dart';
import 'package:ceylife_digital/utils/app_constants.dart';
import 'package:ceylife_digital/utils/app_localizations.dart';
import 'package:ceylife_digital/utils/navigation_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CeylifeDigitalApp extends StatefulWidget {
  @override
  _CeylifeDigitalAppState createState() => _CeylifeDigitalAppState();
}

class _CeylifeDigitalAppState extends State<CeylifeDigitalApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      builder: () {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AppDataProvider()),
          ],
          child: AppBuilder(
            builder: (context){
              return MaterialApp(
                title: AppConstants.appName,
                onGenerateRoute: Routes.generateRoute,
                initialRoute: Routes.SPLASH_VIEW,
                builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 0.85),
                    child: child),
                theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  primaryColor: AppColors.primaryBackgroundColor,
                  accentColor: AppColors.appbarSecondary,
                  fontFamily: AppConstants.fontFamily,
                  highlightColor: AppColors.appHighlightColor,
                  unselectedWidgetColor: Colors.white,
                ),
                supportedLocales: [
                  Locale(AppConstants.localeEN, "US"),
                  Locale(AppConstants.localeSI, "LK"),
                  Locale(AppConstants.localeTA, "TA")
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
