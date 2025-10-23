import 'package:flutter/material.dart';

import '../../../../core/consts/route_consts.dart';
import '../../../../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, gameBoardRoute),
            child: Text(t.translate('battle')),
          ),
        ],
      ),
    );
  }
}
