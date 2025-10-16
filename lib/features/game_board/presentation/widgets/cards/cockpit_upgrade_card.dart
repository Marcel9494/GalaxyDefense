import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CockpitUpgradeCard extends StatefulWidget {
  final String title;
  final num currentValue;
  final num nextValue;
  final int upgradeCost;

  const CockpitUpgradeCard({
    super.key,
    required this.title,
    required this.currentValue,
    required this.nextValue,
    required this.upgradeCost,
  });

  @override
  State<CockpitUpgradeCard> createState() => _CockpitUpgradeCardState();
}

class _CockpitUpgradeCardState extends State<CockpitUpgradeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 6.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: AutoSizeText(
                  widget.title,
                  style: const TextStyle(fontSize: 16.0),
                  minFontSize: 12.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                onPressed: () {
                  // TODO Fertigkeit upgrade
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: BorderSide(color: Colors.cyanAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            widget.currentValue.toString(),
                            style: const TextStyle(fontSize: 12.0, color: Colors.white),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          AutoSizeText(
                            widget.nextValue.toString(),
                            style: const TextStyle(fontSize: 12.0, color: Colors.white),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      AutoSizeText(
                        '${widget.upgradeCost.toString()} Credits',
                        style: const TextStyle(fontSize: 12.0, color: Colors.white),
                        minFontSize: 10.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
