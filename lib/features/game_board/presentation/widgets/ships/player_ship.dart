import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/game_board/presentation/widgets/ships/ship.dart';

import '../game_elements/projectile_shot.dart';
import 'normal_enemy.dart';

class PlayerShip extends Ship {
  double shootTimer = 0.0;
  final double shootInterval = 0.5;

  static final _paintPlayerShip = Paint()
    ..color = Colors.cyanAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  static final _paintPlayerShipShield = Paint()
    ..color = Colors.blueAccent
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  PlayerShip({required super.size})
      : super(
          maxHealth: 5,
          maxShield: 5,
          damage: 1,
          speed: 0,
          fireDistance: 0,
        );

  @override
  void renderShip(Canvas canvas) {
    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(0, size.y)
      ..lineTo(size.x, size.y)
      ..close();

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), 60, _paintPlayerShipShield);
    canvas.drawPath(path, _paintPlayerShip);
  }

  @override
  void updateShip(double dt) {
    shootTimer += dt;
    if (shootTimer >= shootInterval) {
      shootTimer = 0.0;
      final enemies = game.children.whereType<NormalEnemy>().toList();
      final enemiesOverAttackLine = enemies.where((e) => e.position.y >= game.attackLine.lineY).toList();

      if (enemiesOverAttackLine.isNotEmpty) {
        shootAtNearestEnemy(enemiesOverAttackLine);
      }
    }
  }

  @override
  void destroyShip() {
    super.destroyShip();
    game.pauseEngine();
    game.overlays.add('GameOverDialog');
    // TODO Animationen hinzufügen
  }

  void shootAtNearestEnemy(List<Ship> enemies) {
    if (enemies.isEmpty) {
      return;
    }
    // Nächsten Gegner finden
    enemies.sort((a, b) => (a.position - position).length.compareTo((b.position - position).length));
    final target = enemies.first;

    // Richtung zum Gegner
    final dir = (target.position - position).normalized();

    // Laser erzeugen und hinzufügen
    final laser = ProjectileShot(startPosition: position.clone(), direction: dir);
    game.add(laser);
  }
}
