import 'package:flutter/cupertino.dart';

import '../cards/cockpit_upgrade_card.dart';

class CockpitUpgradeGridView extends StatelessWidget {
  final List<CockpitUpgradeCard> upgradeCards;

  const CockpitUpgradeGridView({
    super.key,
    required this.upgradeCards,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 1,
      ),
      itemCount: upgradeCards.length,
      itemBuilder: (context, index) {
        return upgradeCards[index];
      },
    );
  }
}
