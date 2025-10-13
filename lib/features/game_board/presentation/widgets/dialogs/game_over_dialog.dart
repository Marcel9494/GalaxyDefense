import 'package:flutter/material.dart';

import '../../../../player/presentation/pages/main_page.dart';
import '../../pages/game_board_page.dart';

class GameOverDialog extends StatelessWidget {
  final GalaxyDefenseGame game;

  const GameOverDialog({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'GAME OVER',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Zerstörte Gegner: ${game.enemiesDestroyed}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              'Erfahrung: ${game.experiencePoints}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              'Credits: ${game.credits}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              'Beskar: ${game.beskar}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('GameOverDialog');
                    game.resetGame();
                  },
                  child: const Text('Neues Spiel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text('Spiel beenden'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
