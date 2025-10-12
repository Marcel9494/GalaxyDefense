import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../pages/game_board_page.dart';
import '../game_elements/laser_shot.dart';
import 'normal_enemy.dart';

class PlayerShip extends PositionComponent with HasGameReference<GalaxyDefenseGame>, CollisionCallbacks {
  int maxHealthPoints = 5;
  int currentHealthPoints = 5;
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

  PlayerShip({super.position, super.size}) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(0, size.y)
      ..lineTo(size.x, size.y)
      ..close();

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), 60, _paintPlayerShipShield);

    canvas.drawPath(path, _paintPlayerShip);
  }

  @override
  void update(double dt) {
    super.update(dt);

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

  void shootAtNearestEnemy(List<NormalEnemy> enemies) {
    // Falls die Liste leer ist, abbrechen
    if (enemies.isEmpty) return;

    // Nächsten Gegner finden
    enemies.sort(
      (a, b) => (a.position - position).length.compareTo((b.position - position).length),
    );
    final target = enemies.first;

    // Richtung zum Gegner
    final dir = (target.position - position).normalized();

    // Laser erzeugen und hinzufügen
    final laser = LaserShot(startPosition: position.clone(), direction: dir);
    game.add(laser);
  }

  void takeDamage(int damage) {
    currentHealthPoints -= damage;
    if (currentHealthPoints <= 0) {
      destroy();
    }
  }

  void destroy() {
    removeFromParent();
  }
}
