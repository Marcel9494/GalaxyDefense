import 'package:flutter/material.dart';
import 'package:galaxy_defense/core/consts/route_consts.dart';
import 'package:galaxy_defense/features/settings/presentation/widgets/cards/setting_card.dart';
import 'package:galaxy_defense/features/settings/presentation/widgets/deco/setting_title.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../data/models/player/player_model.dart';

class SettingsPage extends StatefulWidget {
  final Player player;

  const SettingsPage({
    super.key,
    required this.player,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('settings')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingTitle(title: 'settings'),
            Card(
              child: ListTile(
                title: Text(t.translate('sound')),
                trailing: Switch(
                  value: isSoundOn,
                  onChanged: (bool value) {
                    setState(() {
                      isSoundOn = value;
                    });
                  },
                ),
              ),
            ),
            SettingTitle(title: 'legal'),
            SettingCard(text: 'privacy_policy', route: privacyPolicyRoute),
            SettingCard(text: 'imprint', route: imprintRoute),
            SettingCard(text: 'credits', route: creditsRoute),
            SettingCard(text: 'above_galaxy_defense', route: aboutGalaxyDefenseRoute),
          ],
        ),
      ),
    );
  }
}
