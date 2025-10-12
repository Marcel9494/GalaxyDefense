import 'package:flutter/material.dart';

class LinearIndicator extends StatelessWidget {
  final int maxValue;
  int currentValue;
  final Color color;
  final double width;
  final double height;
  final Duration animationDuration;

  LinearIndicator({
    super.key,
    required this.maxValue,
    required this.currentValue,
    required this.color,
    this.width = 200,
    this.height = 20,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  double calculatePercent() {
    assert(maxValue > 0, 'maxHealth must be greater than 0');
    if (currentValue <= 0 || maxValue <= 0) {
      currentValue = 0;
      return 0;
    }
    return currentValue / maxValue;
  }

  @override
  Widget build(BuildContext context) {
    final double percent = calculatePercent();

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.transparent,
          ),
          clipBehavior: Clip.hardEdge,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: percent),
            duration: animationDuration,
            builder: (context, value, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          '$currentValue / $maxValue',
          style: TextStyle(
            color: Colors.white,
            fontSize: height * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
