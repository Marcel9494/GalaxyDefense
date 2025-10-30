import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/hangar/presentation/pages/hangar_page.dart';
import 'package:galaxy_defense/features/player/presentation/pages/home_page.dart';
import 'package:galaxy_defense/features/ranking/presentation/pages/ranking_page.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../data/models/player/player_model.dart';
import '../../../shop/presentation/pages/shop_page.dart';

class MainPage extends StatefulWidget {
  final Player player;

  const MainPage({
    super.key,
    required this.player,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        HugeIcon(icon: HugeIcons.strokeRoundedCProgramming, color: Colors.amber, size: 20.0),
                        const SizedBox(width: 4.0),
                        Text(widget.player.availableCredits.toString(), style: const TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        HugeIcon(icon: HugeIcons.strokeRoundedBitcoinCpu, color: Colors.amber, size: 20.0),
                        const SizedBox(width: 4.0),
                        Text(widget.player.availableBeskar.toString(), style: const TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.lightBlueAccent, size: 20.0),
                        const SizedBox(width: 4.0),
                        Text(widget.player.gainedXp.toString(), style: const TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.military_tech_rounded, color: Colors.green, size: 20.0),
                        const SizedBox(width: 4.0),
                        Text(widget.player.playerLevel.toString(), style: const TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: <Widget>[
                HomePage(player: widget.player),
                HangarPage(),
                RankingPage(),
                ShopPage(),
              ].elementAt(_selectedPageIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: HugeIcon(icon: HugeIcons.strokeRoundedGalaxy), label: t.translate('home')),
          BottomNavigationBarItem(icon: HugeIcon(icon: HugeIcons.strokeRoundedSatellite02), label: t.translate('hangar')),
          BottomNavigationBarItem(icon: HugeIcon(icon: HugeIcons.strokeRoundedRanking), label: t.translate('ranking')),
          BottomNavigationBarItem(icon: HugeIcon(icon: HugeIcons.strokeRoundedRocket01), label: t.translate('shop')),
        ],
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
