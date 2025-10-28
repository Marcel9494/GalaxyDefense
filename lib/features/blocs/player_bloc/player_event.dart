part of 'player_bloc.dart';

abstract class PlayerEvent {}

class LoadPlayer extends PlayerEvent {
  final int playerId;

  LoadPlayer({required this.playerId});
}

class UpdatePlayerStat extends PlayerEvent {
  final int playerId;
  final int upgradeCost;

  UpdatePlayerStat(this.playerId, this.upgradeCost);
}
