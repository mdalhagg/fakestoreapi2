import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fakestoreapi/router.dart';
import 'package:fakestoreapi/theme/light_theme.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    settingsController.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme lightColorScheme = ColorScheme.fromSeed(
      seedColor: LightTheme.main,
    ).harmonized();

    // log(lightColorScheme.toString());

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    TextTheme textTheme = Theme.of(context).textTheme.apply(
          fontFamily: 'Tajawal-Regular',
        );

    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          routerConfig: router,
          title: 'To Babak',
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("ar"), // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: const Locale('ar'),
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: textTheme,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              // foregroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),

        );
      },
    );
  }
}
