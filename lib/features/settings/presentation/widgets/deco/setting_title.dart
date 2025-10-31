import 'package:flutter/cupertino.dart';

import '../../../../../l10n/app_localizations.dart';

class SettingTitle extends StatelessWidget {
  final String title;

  const SettingTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            t.translate(title),
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
