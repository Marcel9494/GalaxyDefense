import 'package:flutter/material.dart';

import '../../../../core/consts/route_consts.dart';
import '../../../../core/page_arguments/player_argument.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../data/models/player/player_model.dart';

class HomePage extends StatefulWidget {
  final Player player;

  const HomePage({
    super.key,
    required this.player,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              gameBoardRoute,
              arguments: PlayerArgument(player: widget.player),
            ),
            child: Text(t.translate('battle')),
          ),
        ],
      ),
    );
  }
}
