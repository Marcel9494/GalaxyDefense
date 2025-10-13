import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../pages/game_board_page.dart';

abstract class Ship extends PositionComponent with HasGameReference<GalaxyDefenseGame>, CollisionCallbacks {
  int maxHealth;
  int currentHealth;
  int maxShield;
  int currentShield;
  int damage;
  int speed;
  int fireDistance;

  Ship({
    required this.maxHealth,
    required this.maxShield,
    required this.damage,
    required this.speed,
    required this.fireDistance,
    this.currentHealth = 0,
    this.currentShield = 0,
    required Vector2 size,
    Anchor anchor = Anchor.center,
  }) : super(size: size, anchor: anchor) {
    currentHealth = maxHealth;
    currentShield = maxShield;
  }

  void takeDamage(int damage) {
    currentHealth -= damage;
    if (currentHealth <= 0) {
      destroyShip();
      removeFromParent();
    }
  }

  void destroyShip() {
    removeFromParent();
  }

  // Abstrakte Methoden: müssen in Unterklassen implementiert werden
  void renderShip(Canvas canvas);
  void updateShip(double dt);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderShip(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updateShip(dt);
  }
}
