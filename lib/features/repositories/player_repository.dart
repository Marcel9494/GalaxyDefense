import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/models/player/player_model.dart';

class PlayerRepository {
  Future<Player> fetchPlayer({required int playerId}) async {
    final supabase = Supabase.instance.client;
    final playerData = await supabase.from('player').select().eq('id', playerId).single();
    return Player.fromMap(playerData);
  }

  Future<void> upgradePlayerStat({required int playerId, required int upgradeCost}) async {
    final supabase = Supabase.instance.client;

    final playerResponse = await supabase.from('player').select('covering_level, available_credits').eq('id', playerId).single();

    final int currentCoveringLevel = playerResponse['covering_level'];
    final int availableCredits = playerResponse['available_credits'];

    if (availableCredits < upgradeCost) {
      return;
    }

    await supabase.from('player').update({
      'covering_level': currentCoveringLevel + 1,
      'available_credits': availableCredits - upgradeCost,
    }).eq('id', playerId);
  }
}
