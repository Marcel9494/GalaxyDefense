import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HangarUpgradeCard extends StatefulWidget {
  final String title;
  final int level;
  final num currentValue;
  final num nextValue;
  final int upgradeCost;

  const HangarUpgradeCard({
    super.key,
    required this.title,
    required this.level,
    required this.currentValue,
    required this.nextValue,
    required this.upgradeCost,
  });

  @override
  State<HangarUpgradeCard> createState() => _HangarUpgradeCardState();
}

class _HangarUpgradeCardState extends State<HangarUpgradeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 6.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            widget.title,
                            style: const TextStyle(fontSize: 18.0),
                            minFontSize: 12.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Level: ${widget.level.toString()}',
                            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 40.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: AutoSizeText(
                      widget.currentValue.toString(),
                      style: const TextStyle(fontSize: 18.0, color: Colors.white),
                      minFontSize: 10.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_double_arrow_right_rounded,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: AutoSizeText(
                      widget.nextValue.toString(),
                      style: const TextStyle(fontSize: 18.0, color: Colors.white),
                      minFontSize: 10.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: AutoSizeText(
                          'Upgraden für\n${widget.upgradeCost.toString()} Credits',
                          style: const TextStyle(fontSize: 12.0, color: Colors.white),
                          minFontSize: 10.0,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
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
