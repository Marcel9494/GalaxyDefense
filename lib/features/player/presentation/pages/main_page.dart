import 'package:flutter/material.dart';
import 'package:galaxy_defense/features/hangar/presentation/pages/hangar_page.dart';
import 'package:galaxy_defense/features/player/presentation/pages/home_page.dart';
import 'package:galaxy_defense/features/ranking/presentation/pages/ranking_page.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../shop/presentation/pages/shop_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPageIndex = 0;
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    HangarPage(),
    RankingPage(),
    ShopPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('galaxy_defense')),
      ),
      body: _pages.elementAt(_selectedPageIndex),
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
