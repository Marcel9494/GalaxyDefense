import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../blocs/player_bloc/player_bloc.dart';
import '../../../data/models/upgrades/covering_model.dart';
import '../../../game_board/presentation/widgets/tabbar/upgrade_tab.dart';
import '../../../repositories/player_repository.dart';
import '../widgets/cards/max_upgrade_card.dart';
import '../widgets/cards/upgrade_card.dart';

class HangarPage extends StatefulWidget {
  const HangarPage({super.key});

  @override
  State<HangarPage> createState() => _HangarPageState();
}

class _HangarPageState extends State<HangarPage> with TickerProviderStateMixin {
  late final TabController _hangarTabController;
  List<Covering> coveringList = [1, 2, 3, 4, 5].map((level) {
    return Covering(
      level: level,
      coveringValue: level * 5,
      upgradeCost: level * 20,
    );
  }).toList();

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
    final t = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => PlayerBloc(PlayerRepository())..add(LoadPlayer(playerId: 0)),
      child: Column(
        children: [
          TabBar(
            controller: _hangarTabController,
            indicatorColor: Colors.cyanAccent,
            labelColor: Colors.cyanAccent,
            tabs: <Widget>[
              UpgradeTab(title: t.translate('attack'), hugeIcon: HugeIcons.strokeRoundedRocket),
              UpgradeTab(title: t.translate('defense'), hugeIcon: HugeIcons.strokeRoundedShield02),
              UpgradeTab(title: t.translate('skills'), hugeIcon: HugeIcons.strokeRoundedChip),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _hangarTabController,
              children: <Widget>[
                SizedBox.shrink(),
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    if (state is PlayerLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PlayerLoaded) {
                      return ListView.builder(
                        itemCount: coveringList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return index == state.player.coveringLevel - 1
                              ? index != coveringList.length - 1
                                  ? UpgradeCard(
                                      title: t.translate('covering'),
                                      level: coveringList[index].level,
                                      currentValue: coveringList[index].coveringValue,
                                      nextValue: coveringList[index].level != 5 ? coveringList[index + 1].coveringValue : 0,
                                      upgradeCost: coveringList[index].upgradeCost,
                                      currentCredits: state.player.availableCredits,
                                    )
                                  : MaxUpgradeCard(
                                      title: t.translate('covering'),
                                      level: coveringList[index].level,
                                      currentValue: coveringList[index].coveringValue,
                                    )
                              : SizedBox.shrink();
                        },
                      );
                    } else if (state is PlayerError) {
                      Future.microtask(() {
                        Flushbar(
                          message: t.translate(state.message),
                          duration: const Duration(seconds: 4),
                          flushbarPosition: FlushbarPosition.TOP,
                          borderRadius: BorderRadius.circular(8.0),
                          margin: const EdgeInsets.all(8.0),
                          icon: const Icon(Icons.error, color: Colors.redAccent),
                        ).show(context);
                      });
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, color: Colors.redAccent, size: 42.0),
                            const SizedBox(height: 12.0),
                            Text(
                              t.translate('load_data_error'),
                              style: TextStyle(color: Colors.redAccent, fontSize: 18.0),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
