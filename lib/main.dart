import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:galaxy_defense/core/consts/route_consts.dart';
import 'package:galaxy_defense/features/player/presentation/pages/main_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/page_arguments/game_board_arguments.dart';
import 'core/page_arguments/home_arguments.dart';
import 'core/page_arguments/main_arguments.dart';
import 'core/theme/theme_data.dart';
import 'features/game_board/presentation/pages/game_board_page.dart';
import 'features/loading/presentation/pages/loading_page.dart';
import 'features/player/presentation/pages/home_page.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
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
      home: const LoadingPage(),
      routes: {},
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case mainRoute:
            final args = settings.arguments as MainArguments;
            return MaterialPageRoute<String>(
              builder: (context) => MainPage(
                player: args.player,
              ),
              settings: settings,
            );
          case homeRoute:
            final args = settings.arguments as HomeArguments;
            return MaterialPageRoute<String>(
              builder: (context) => HomePage(
                player: args.player,
              ),
              settings: settings,
            );
          case gameBoardRoute:
            final args = settings.arguments as GameBoardArguments;
            return MaterialPageRoute<String>(
              builder: (context) => GameBoardPage(
                player: args.player,
              ),
              settings: settings,
            );
        }
        return null;
      },
    );
  }
}
