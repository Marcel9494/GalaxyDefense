part of 'player_bloc.dart';

abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerLoaded extends PlayerState {
  final Player player;
  PlayerLoaded(this.player);
}

class PlayerError extends PlayerState {
  final String message;
  PlayerError(this.message);
}
