import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Galaxy Defense'),
      ),
      body: GameWidget(
        game: GalaxyDefenseGame(),
      ),
    );
  }
}

class GalaxyDefenseGame extends FlameGame {
  PlayerShip playerShip = PlayerShip(size: Vector2(50, 50));

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
}
