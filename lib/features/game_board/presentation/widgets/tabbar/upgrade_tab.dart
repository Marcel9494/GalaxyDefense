import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class UpgradeTab extends StatelessWidget {
  final String title;
  final List<List<dynamic>> hugeIcon;

  const UpgradeTab({
    super.key,
    required this.title,
    required this.hugeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: hugeIcon,
            size: 18.0,
          ),
          SizedBox(width: 3.0),
          Text(
            title,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
