import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  final Widget icon;
  final String text;

  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          icon,
          SizedBox(width: 4.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
