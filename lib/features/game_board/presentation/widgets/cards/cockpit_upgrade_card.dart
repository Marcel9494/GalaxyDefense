import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CockpitUpgradeCard extends StatefulWidget {
  final String title;
  final num currentValue;
  final num nextValue;
  final int upgradeCost;
  final VoidCallback onPressed;
  final int currentTokens;

  const CockpitUpgradeCard({
    super.key,
    required this.title,
    required this.currentValue,
    required this.nextValue,
    required this.upgradeCost,
    required this.onPressed,
    required this.currentTokens,
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
                onPressed: widget.onPressed,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: BorderSide(color: widget.upgradeCost <= widget.currentTokens ? Colors.cyanAccent : Colors.grey),
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
                            style: TextStyle(fontSize: 12.0, color: widget.upgradeCost <= widget.currentTokens ? Colors.white : Colors.grey),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.keyboard_double_arrow_right_rounded,
                            color: widget.upgradeCost <= widget.currentTokens ? Colors.white : Colors.grey,
                            size: 16.0,
                          ),
                          AutoSizeText(
                            widget.nextValue.toString(),
                            style: TextStyle(fontSize: 12.0, color: widget.upgradeCost <= widget.currentTokens ? Colors.white : Colors.grey),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            widget.upgradeCost.toString(),
                            style: TextStyle(fontSize: 12.0, color: widget.upgradeCost <= widget.currentTokens ? Colors.white : Colors.grey),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.token_rounded, size: 16.0, color: widget.upgradeCost <= widget.currentTokens ? Colors.white : Colors.grey),
                        ],
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
