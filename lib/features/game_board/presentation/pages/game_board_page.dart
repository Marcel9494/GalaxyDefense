import 'package:flutter/material.dart';

import '../widgets/painter/spaceship_painter.dart';

class GameBoardPage extends StatefulWidget {
  const GameBoardPage({super.key});

  @override
  State<GameBoardPage> createState() => _GameBoardPageState();
}

class _GameBoardPageState extends State<GameBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galaxy Defense'),
      ),
      body: Center(
        child: CustomPaint(
          painter: SpaceshipPainter(),
          size: Size(100, 100),
        ),
      ),
    );
  }
}
