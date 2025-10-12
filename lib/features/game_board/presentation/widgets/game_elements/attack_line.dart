import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class AttackLine extends PositionComponent {
  final double lineY;

  static final _paintAttackLine = Paint()
    ..color = Colors.redAccent
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  AttackLine({required this.lineY});

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.x, lineY),
      _paintAttackLine,
    );
  }
}
