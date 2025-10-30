import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/cards/cockpit_upgrade_card.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/game_elements/attack_line.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/grid_view/cockpit_upgrade_grid_view.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/tabbar/upgrade_tab.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/consts/dialog_consts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../data/models/player/player_model.dart';
import '../../../data/models/upgrades/covering_model.dart';
import '../widgets/deco/linear_indicator.dart';
import '../widgets/dialogs/game_over_dialog.dart';
import '../widgets/ships/normal_enemy.dart';
import '../widgets/ships/player_ship.dart';

class GameBoardPage extends StatefulWidget {
  final Player player;

  const GameBoardPage({
    super.key,
    required this.player,
  });

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> with TickerProviderStateMixin {
  late final GalaxyDefenseGame _game;
  late final TabController _cockpitTabController;
  List<Covering> coveringList = [1, 2, 3, 4, 5].map((level) {
    return Covering(
      level: level,
      coveringValue: level * 5,
      upgradeCost: level * 20,
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    _cockpitTabController = TabController(length: 2, vsync: this);
    _game = GalaxyDefenseGame();
  }

  @override
  void dispose() {
    _cockpitTabController.dispose();
    super.dispose();
  }

  void _upgradeCovering() {
    final int currentLevel = widget.player.coveringLevel;

    if (currentLevel >= coveringList.length) {
      return;
    }
    final Covering currentCovering = coveringList[currentLevel - 1];
    final Covering nextCovering = coveringList[currentLevel];

    setState(() {
      _game.tokensNotifier.value -= currentCovering.upgradeCost;
      _game.playerShip.maxHealth = nextCovering.coveringValue;
      _game.playerShip.currentHealth += nextCovering.coveringValue - currentCovering.coveringValue;
      _game.playerHealthNotifier.value += nextCovering.coveringValue - currentCovering.coveringValue;
      widget.player.coveringLevel++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: GameWidget(
              game: _game,
              overlayBuilderMap: {
                gameOverDialogId: (context, game) {
                  return GameOverDialog(game: game as GalaxyDefenseGame);
                },
              },
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.loose,
            child: ValueListenableBuilder<int>(
              valueListenable: _game.playerHealthNotifier,
              builder: (context, value, _) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 4.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: LinearIndicator(
                                maxValue: _game.playerShip.maxHealth,
                                currentValue: _game.playerShip.currentHealth,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder<int>(
                                valueListenable: _game.tokensNotifier,
                                builder: (context, tokens, _) {
                                  return Row(
                                    children: [
                                      Icon(Icons.token_rounded, size: 20.0),
                                      SizedBox(width: 4.0),
                                      Text('$tokens', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder<int>(
                                valueListenable: _game.creditsNotifier,
                                builder: (context, credits, _) {
                                  return Row(
                                    children: [
                                      HugeIcon(icon: HugeIcons.strokeRoundedCProgramming, size: 20.0),
                                      SizedBox(width: 4.0),
                                      Text('$credits', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder<int>(
                                valueListenable: _game.beskarNotifier,
                                builder: (context, beskar, _) {
                                  return Row(
                                    children: [
                                      HugeIcon(icon: HugeIcons.strokeRoundedBitcoinCpu, size: 20.0),
                                      SizedBox(width: 4.0),
                                      Text('$beskar', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: LinearIndicator(
                                maxValue: _game.playerShip.maxShield,
                                currentValue: _game.playerShip.currentShield,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder<int>(
                                valueListenable: _game.killCountNotifier,
                                builder: (context, kills, _) {
                                  return Row(
                                    children: [
                                      HugeIcon(icon: HugeIcons.strokeRoundedAlien01, size: 20.0),
                                      SizedBox(width: 4.0),
                                      Text('$kills', style: const TextStyle(color: Colors.white, fontSize: 16)),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ValueListenableBuilder<int>(
                                valueListenable: _game.xpNotifier,
                                builder: (context, xp, _) {
                                  return Text('${t.translate('xp')} $xp', style: const TextStyle(color: Colors.white, fontSize: 16));
                                },
                              ),
                            ),
                            Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TabBar(
                              controller: _cockpitTabController,
                              indicatorColor: Colors.cyanAccent,
                              labelColor: Colors.cyanAccent,
                              tabs: <Widget>[
                                UpgradeTab(title: t.translate('attack'), hugeIcon: HugeIcons.strokeRoundedRocket),
                                UpgradeTab(title: t.translate('defense'), hugeIcon: HugeIcons.strokeRoundedShield02),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _cockpitTabController,
                                children: <Widget>[
                                  CockpitUpgradeGridView(
                                    upgradeCards: [
                                      CockpitUpgradeCard(
                                        title: t.translate('projectile_damage'),
                                        currentValue: 1.0,
                                        nextValue: 2.0,
                                        upgradeCost: 10,
                                        onPressed: () {},
                                        currentTokens: _game.tokensNotifier.value,
                                      ),
                                    ],
                                  ),
                                  CockpitUpgradeGridView(
                                    upgradeCards: [
                                      CockpitUpgradeCard(
                                        title: t.translate('covering'),
                                        currentValue: coveringList[widget.player.coveringLevel - 1].coveringValue,
                                        nextValue: coveringList[widget.player.coveringLevel].coveringValue,
                                        upgradeCost: coveringList[widget.player.coveringLevel - 1].upgradeCost,
                                        onPressed: () => coveringList[widget.player.coveringLevel - 1].upgradeCost <= _game.tokensNotifier.value
                                            ? _upgradeCovering()
                                            : null,
                                        currentTokens: _game.tokensNotifier.value,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
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
  int beskar = 0;
  int enemiesDestroyed = 0;

  final ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> tokensNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> creditsNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> beskarNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> killCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> playerHealthNotifier = ValueNotifier<int>(5);

  bool isPlayerShipOnCooldown = false;
  final double attackCooldown = 0.5;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    createGameComponents();
  }

  @override
  void update(double dt) {
    super.update(dt);
    playerHealthNotifier.value = playerShip.currentHealth;
  }

  void createGameComponents() {
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
          return NormalEnemy(size: Vector2(20, 20));
        },
        period: 0.35,
        area: Rectangle.fromLTWH(0, -NormalEnemy.normalEnemySize, size.x, NormalEnemy.normalEnemySize),
      ),
    );

    playerHealthNotifier.value = playerShip.maxHealth;
    isPlayerShipOnCooldown = false;
  }

  void onEnemyDestroyed() {
    experiencePoints += 10;
    credits += 2;
    beskar++;
    enemiesDestroyed++;

    xpNotifier.value = experiencePoints;
    tokensNotifier.value += 2;
    creditsNotifier.value = credits;
    beskarNotifier.value = beskar;
    killCountNotifier.value = enemiesDestroyed;
  }

  void resetGame() {
    experiencePoints = 0;
    credits = 0;
    beskar = 0;
    enemiesDestroyed = 0;

    xpNotifier.value = 0;
    tokensNotifier.value = 0;
    creditsNotifier.value = 0;
    beskarNotifier.value = 0;
    killCountNotifier.value = 0;

    removeAll(children.toList());

    playerShip = PlayerShip(size: Vector2(50, 50));
    createGameComponents();

    resumeEngine();
  }
}
