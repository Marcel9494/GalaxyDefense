import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/game_elements/attack_line.dart';

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
                  return Row(
                    children: [
                      Column(
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
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              ValueListenableBuilder<int>(
                                valueListenable: game.xpNotifier,
                                builder: (context, xp, _) {
                                  return Text('$xp XP', style: const TextStyle(color: Colors.white, fontSize: 16));
                                },
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable: game.creditsNotifier,
                                builder: (context, credits, _) {
                                  return Text('Credits: $credits', style: const TextStyle(color: Colors.white, fontSize: 16));
                                },
                              ),
                            ],
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: game.killCountNotifier,
                            builder: (context, kills, _) {
                              return Text('$kills', style: const TextStyle(color: Colors.white, fontSize: 16));
                            },
                          ),
                        ],
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

class GalaxyDefenseGame extends FlameGame with HasCollisionDetection {
  PlayerShip playerShip = PlayerShip(size: Vector2(50, 50));
  late AttackLine attackLine;

  int experiencePoints = 0;
  int credits = 0;
  int enemiesDestroyed = 0;

  final ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> creditsNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> killCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> playerHealthNotifier = ValueNotifier<int>(5);

  bool isPlayerOnCooldown = false;
  final double attackCooldown = 0.5;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(playerShip);
    playerShip.position = Vector2(
      size.x / 2,
      size.y - playerShip.size.y - 30,
    );

    attackLine = AttackLine(lineY: size.y - 350)..size = size;
    add(attackLine);

    add(
      SpawnComponent(
        factory: (index) {
          return NormalEnemy();
        },
        period: 0.45,
        area: Rectangle.fromLTWH(0, -NormalEnemy.normalEnemySize, size.x, NormalEnemy.normalEnemySize),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    playerHealthNotifier.value = playerShip.currentHealthPoints;
  }

  void onEnemyDestroyed() {
    experiencePoints += 10;
    credits += 2;
    enemiesDestroyed++;

    xpNotifier.value = experiencePoints;
    creditsNotifier.value = credits;
    killCountNotifier.value = enemiesDestroyed;
  }
}
