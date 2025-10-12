import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../pages/game_board_page.dart';

class PlayerShip extends PositionComponent with HasGameReference<GalaxyDefenseGame> {
  int maxHealthPoints = 5;
  int currentHealthPoints = 5;

  static final _paintPlayerShip = Paint()
    ..color = Colors.cyanAccent
    ..style = PaintingStyle.fill;

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

  void takeDamage(int amount) {
    currentHealthPoints -= amount;
    if (currentHealthPoints <= 0) {
      destroy();
    }
  }

  void destroy() {
    removeFromParent();
  }
}
