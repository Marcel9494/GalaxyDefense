import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GameButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.cyanAccent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.cyanAccent),
      ),
    );
  }
}
