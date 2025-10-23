import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:galaxy_defense/core/consts/route_consts.dart';
import 'package:galaxy_defense/features/player/presentation/pages/main_page.dart';

import 'core/theme/theme_data.dart';
import 'features/game_board/presentation/pages/game_board_page.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy Defense',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      locale: const Locale('de'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainPage(),
      routes: {
        mainRoute: (context) => const MainPage(),
        gameBoardRoute: (context) => const GameBoardPage(),
      },
    );
  }
}
