import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../pages/game_board_page.dart';
import '../ships/normal_enemy.dart';

class LaserShot extends PositionComponent with HasGameReference<GalaxyDefenseGame>, CollisionCallbacks {
  final Vector2 direction;
  final double speed = 300;
  bool destroyed = false;
  static final _paintLaserShot = Paint()..color = Colors.redAccent;

  LaserShot({
    required Vector2 startPosition,
    required this.direction,
  }) : super(
          size: Vector2(4, 20),
          position: startPosition,
        );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paintLaserShot);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (destroyed) {
      return;
    }

    position += direction.normalized() * (speed * dt);

    if (position.y < 0 || position.y > game.size.y || position.x < 0 || position.x > game.size.x) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is NormalEnemy && !destroyed) {
      destroyed = true;
      other.destroy();
      removeFromParent();
    }
  }
}
