import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../game_board/presentation/widgets/tabbar/upgrade_tab.dart';
import '../widgets/cards/hangar_upgrade_card.dart';

class HangarPage extends StatefulWidget {
  const HangarPage({super.key});

  @override
  State<HangarPage> createState() => _HangarPageState();
}

class _HangarPageState extends State<HangarPage> with TickerProviderStateMixin {
  late final TabController _hangarTabController;

  @override
  void initState() {
    super.initState();
    _hangarTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _hangarTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _hangarTabController,
          indicatorColor: Colors.cyanAccent,
          labelColor: Colors.cyanAccent,
          tabs: <Widget>[
            UpgradeTab(title: 'Angriff', hugeIcon: HugeIcons.strokeRoundedRocket),
            UpgradeTab(title: 'Verteidigung', hugeIcon: HugeIcons.strokeRoundedShield02),
            UpgradeTab(title: 'Fähigkeiten', hugeIcon: HugeIcons.strokeRoundedChip),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _hangarTabController,
            children: <Widget>[
              Center(child: Text("Angriff")),
              ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return HangarUpgradeCard(
                    title: "Hülle",
                    level: 1,
                    currentValue: 5,
                    nextValue: 10,
                    upgradeCost: 20,
                  );
                },
              ),
              Center(child: Text("Fähigkeiten")),
            ],
          ),
        ),
      ],
    );
  }
}
