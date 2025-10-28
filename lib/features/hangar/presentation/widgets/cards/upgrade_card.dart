import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defense/features/blocs/player_bloc/player_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../l10n/app_localizations.dart';

class UpgradeCard extends StatefulWidget {
  final String title;
  final int level;
  final num currentValue;
  final num nextValue;
  final int upgradeCost;
  final int currentCredits;

  const UpgradeCard({
    super.key,
    required this.title,
    required this.level,
    required this.currentValue,
    required this.nextValue,
    required this.upgradeCost,
    required this.currentCredits,
  });

  @override
  State<UpgradeCard> createState() => _UpgradeCardState();
}

class _UpgradeCardState extends State<UpgradeCard> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
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
                            '${t.translate('current_level')}: ${widget.level.toString()}',
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
                  widget.upgradeCost <= widget.currentCredits ? context.read<PlayerBloc>().add(UpdatePlayerStat(0, widget.upgradeCost)) : null;
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: BorderSide(color: widget.upgradeCost <= widget.currentCredits ? Colors.cyanAccent : Colors.grey),
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
                          t.translate('upgrade_for'),
                          style: TextStyle(fontSize: 12.0, color: widget.upgradeCost <= widget.currentCredits ? Colors.white : Colors.grey),
                          minFontSize: 10.0,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            widget.upgradeCost.toString(),
                            style: TextStyle(fontSize: 12.0, color: widget.upgradeCost <= widget.currentCredits ? Colors.white : Colors.grey),
                            minFontSize: 10.0,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 4.0),
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedCProgramming,
                            size: 16.0,
                            color: widget.upgradeCost <= widget.currentCredits ? Colors.white : Colors.grey,
                          ),
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
