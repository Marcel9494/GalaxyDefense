import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/ships/player_ship.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/ships/ship.dart';

class NormalEnemy extends Ship {
  static const double normalEnemySize = 30;

  static final _paintNormalEnemy = Paint()
    ..color = Colors.redAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  NormalEnemy({required super.size})
      : super(
          maxHealth: 1,
          maxShield: 0,
          damage: 1,
          speed: 100,
          fireDistance: 80,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void renderShip(Canvas canvas) {
    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(0, size.y)
      ..lineTo(size.x, size.y)
      ..close();

    canvas.drawPath(path, _paintNormalEnemy);
  }

  @override
  void updateShip(double dt) {
    final PlayerShip playerShip = game.playerShip;

    final Vector2 toPlayer = playerShip.position - position;
    final double distanceToPlayer = toPlayer.length;

    if (distanceToPlayer > fireDistance) {
      // Normalisieren, um Richtungseinheitsvektor zu bekommen
      final Vector2 direction = toPlayer.normalized();
      lookAt(playerShip.position);
      position += direction * (speed * dt);
    } else {
      // Angriff von Gegner auf Spieler
      playerShip.takeDamage(damage);
      removeFromParent();
    }
  }

  @override
  void destroyShip() {
    super.destroyShip();
    game.onEnemyDestroyed();
    // TODO Animationen hinzufügen
  }
}
