import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:galaxy_defense/core/consts/route_consts.dart';
import 'package:galaxy_defense/features/player/presentation/pages/main_page.dart';
import 'package:galaxy_defense/features/settings/presentation/pages/above_galaxy_defense_page.dart';
import 'package:galaxy_defense/features/settings/presentation/pages/credits_page.dart';
import 'package:galaxy_defense/features/settings/presentation/pages/imprint_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/page_arguments/player_argument.dart';
import 'core/theme/theme_data.dart';
import 'features/game_board/presentation/pages/game_board_page.dart';
import 'features/loading/presentation/pages/loading_page.dart';
import 'features/player/presentation/pages/home_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';
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
      routes: {
        imprintRoute: (context) => const ImprintPage(),
        creditsRoute: (context) => const CreditsPage(),
        aboutGalaxyDefenseRoute: (context) => const AboutGalaxyDefensePage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case mainRoute:
            final args = settings.arguments as PlayerArgument;
            return MaterialPageRoute<String>(
              builder: (context) => MainPage(
                player: args.player,
              ),
              settings: settings,
            );
          case homeRoute:
            final args = settings.arguments as PlayerArgument;
            return MaterialPageRoute<String>(
              builder: (context) => HomePage(
                player: args.player,
              ),
              settings: settings,
            );
          case gameBoardRoute:
            final args = settings.arguments as PlayerArgument;
            return MaterialPageRoute<String>(
              builder: (context) => GameBoardPage(
                player: args.player,
              ),
              settings: settings,
            );
          case settingsRoute:
            final args = settings.arguments as PlayerArgument;
            return MaterialPageRoute<String>(
              builder: (context) => SettingsPage(
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
