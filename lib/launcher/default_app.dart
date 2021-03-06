import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter_template/generated/i18n.dart';
import 'package:my_flutter_template/launcher/splash.dart';
import 'package:my_flutter_template/launcher/router/route_map.dart';
import 'package:my_flutter_template/launcher/router/router.dart';
import 'package:my_flutter_template/utils/provider.dart';
import 'package:my_flutter_template/utils/sputils.dart';
import 'package:my_flutter_template/utils/toast.dart';
import 'package:provider/provider.dart';

class DefaultApp {
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();
    SPUtils.init().then((value) => runApp(Store.init(MyApp())));

    initApp();
  }

  static void initApp() {
    // Router
    XRouter.init();
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppTheme, LocaleModel>(
        builder: (context, appTheme, localeModel, _) {
      return ToastUtils.init(MaterialApp(
        title: 'Flutter Project',
        theme: ThemeData(
          primarySwatch: appTheme.themeColor,
          buttonColor: appTheme.themeColor,
        ),
        home: SplashPage(),
        onGenerateRoute: XRouter.router.generator,
        routes: RouteMap.routes,
        locale: localeModel.getLocale(),
        supportedLocales: I18n.delegate.supportedLocales,
        localizationsDelegates: [
          I18n.delegate,
          GlobalEasyRefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback:
            (Locale _locale, Iterable<Locale> supportedLocales) {
          if (localeModel.getLocale() != null) {
            //如果已经选定语言，则不跟随系统
            return localeModel.getLocale();
          } else {
            //跟随系统
            if (I18n.delegate.isSupported(_locale)) {
              return _locale;
            }
            return supportedLocales.first;
          }
        },
      ));
    });
  }
}