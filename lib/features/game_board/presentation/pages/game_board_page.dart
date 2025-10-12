import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../widgets/deco/linear_indicator.dart';
import '../widgets/ships/normal_enemy.dart';
import '../widgets/ships/playership.dart';

class GameBoardPage extends StatefulWidget {
  const GameBoardPage({super.key});

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  @override
  Widget build(BuildContext context) {
    final game = GalaxyDefenseGame();
    return Scaffold(
      appBar: AppBar(
        title: Text('Galaxy Defense'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: GameWidget(
              game: game,
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder<int>(
                valueListenable: game.playerHealthNotifier,
                builder: (context, value, _) {
                  return Column(
                    children: [
                      LinearIndicator(
                        maxValue: game.playerShip.maxHealthPoints,
                        currentValue: game.playerShip.currentHealthPoints,
                        color: Colors.green,
                      ),
                      SizedBox(height: 6.0),
                      LinearIndicator(
                        maxValue: game.playerShip.maxHealthPoints,
                        currentValue: game.playerShip.currentHealthPoints,
                        color: Colors.blue,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GalaxyDefenseGame extends FlameGame {
  PlayerShip playerShip = PlayerShip(size: Vector2(50, 50));
  final playerHealthNotifier = ValueNotifier<int>(5);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(playerShip);
    playerShip.position = canvasSize / 2;

    add(
      SpawnComponent(
        factory: (index) {
          return NormalEnemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, -NormalEnemy.normalEnemySize, size.x, NormalEnemy.normalEnemySize),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    playerHealthNotifier.value = playerShip.currentHealthPoints;
  }
}
