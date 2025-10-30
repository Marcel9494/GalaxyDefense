import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/buttons/game_button.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/consts/dialog_consts.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../pages/game_board_page.dart';

class GameOverDialog extends StatelessWidget {
  final GalaxyDefenseGame game;

  const GameOverDialog({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.translate('game_over'),
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedAlien01, size: 20.0),
                SizedBox(width: 4.0),
                Text('${game.enemiesDestroyed}', style: const TextStyle(color: Colors.white, fontSize: 18.0)),
                SizedBox(width: 24.0),
                Text('${t.translate('xp')}: ${game.experiencePoints}', style: const TextStyle(color: Colors.white, fontSize: 18.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(icon: HugeIcons.strokeRoundedCProgramming, size: 20.0),
                SizedBox(width: 4.0),
                Text('${game.credits}', style: const TextStyle(color: Colors.white, fontSize: 18.0)),
                SizedBox(width: 24.0),
                HugeIcon(icon: HugeIcons.strokeRoundedBitcoinCpu, size: 20.0),
                SizedBox(width: 4.0),
                Text('${game.beskar}', style: const TextStyle(color: Colors.white, fontSize: 18.0)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameButton(
                  text: t.translate('new_battle'),
                  onPressed: () {
                    game.overlays.remove(gameOverDialogId);
                    game.resetGame();
                  },
                ),
                SizedBox(width: 8.0),
                GameButton(
                  text: t.translate('home'),
                  onPressed: () {
                    /* TODO Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false,
                    );*/
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
