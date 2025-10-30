import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../blocs/player_bloc/player_bloc.dart';
import '../../../player/presentation/pages/main_page.dart';
import '../../../repositories/player_repository.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => PlayerBloc(PlayerRepository())..add(LoadPlayer(playerId: 0)),
      child: BlocListener<PlayerBloc, PlayerState>(
        listenWhen: (previous, current) => current is PlayerLoaded || current is PlayerError,
        listener: (context, state) {
          if (state is PlayerLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MainPage(player: state.player),
              ),
            );
          } else if (state is PlayerError) {
            Future.microtask(() {
              Flushbar(
                message: t.translate('load_player_error'),
                duration: const Duration(seconds: 4),
                flushbarPosition: FlushbarPosition.TOP,
                borderRadius: BorderRadius.circular(8.0),
                margin: const EdgeInsets.all(8.0),
                icon: const Icon(Icons.error, color: Colors.redAccent),
              ).show(context);
            });
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FlutterLogo(
                  size: 100.0,
                  style: FlutterLogoStyle.markOnly,
                  textColor: Colors.cyanAccent,
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
