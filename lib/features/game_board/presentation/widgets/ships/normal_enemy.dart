import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/game_board/presentation/pages/game_board_page.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/ships/playership.dart';

class NormalEnemy extends PositionComponent with HasGameReference<GalaxyDefenseGame> {
  static const double normalEnemySize = 30;
  static const double speed = 150;
  static const double stopDistance = 80;
  int currentHealthPoints = 1;

  NormalEnemy({super.position}) : super(size: Vector2(normalEnemySize, normalEnemySize), anchor: Anchor.center);

  static final _paint = Paint()
    ..color = Colors.redAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(0, size.y)
      ..lineTo(size.x, size.y)
      ..close();

    canvas.drawPath(path, _paint);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    final PlayerShip playerShip = game.playerShip;

    final Vector2 toPlayer = playerShip.position - position;
    final double distanceToPlayer = toPlayer.length;

    if (distanceToPlayer > stopDistance) {
      // Normalisieren, um Richtungseinheitsvektor zu bekommen
      final Vector2 direction = toPlayer.normalized();
      lookAt(playerShip.position);
      position += direction * (speed * dt);
    } else {
      // Angriff von Gegner auf Spieler
      playerShip.takeDamage(1);
      removeFromParent();
    }
  }

  void takeDamage(int damage) {
    currentHealthPoints -= damage;
    if (currentHealthPoints <= 0) {
      destroy();
    }
  }

  void destroy() {
    game.onEnemyDestroyed();
    removeFromParent();
  }
}
