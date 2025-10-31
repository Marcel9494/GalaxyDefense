import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class SettingCard extends StatefulWidget {
  final String text;
  final String route;

  const SettingCard({
    super.key,
    required this.text,
    required this.route,
  });

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Card(
      child: ListTile(
        title: Text(t.translate(widget.text)),
        trailing: Icon(Icons.keyboard_arrow_right_rounded),
        onTap: () => Navigator.pushNamed(context, widget.route),
      ),
    );
  }
}
