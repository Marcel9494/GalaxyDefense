import 'package:bloc/bloc.dart';
import 'package:galaxy_defense/features/repositories/player_repository.dart';

import '../../data/models/player/player_model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final PlayerRepository _playerRepository;

  PlayerBloc(this._playerRepository) : super(PlayerInitial()) {
    on<LoadPlayer>(_onLoadPlayer);
    on<UpdatePlayerStat>(_onUpdatePlayerStat);
  }

  Future<void> _onLoadPlayer(LoadPlayer event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    try {
      final loadedPlayer = await _playerRepository.fetchPlayer(playerId: event.playerId);
      emit(PlayerLoaded(loadedPlayer));
    } catch (e) {
      emit(PlayerError('load_player_error'));
    }
  }

  Future<void> _onUpdatePlayerStat(UpdatePlayerStat event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    try {
      await _playerRepository.upgradePlayerStat(playerId: event.playerId, upgradeCost: event.upgradeCost);

      final updatedPlayer = await _playerRepository.fetchPlayer(playerId: event.playerId);
      emit(PlayerLoaded(updatedPlayer));
    } catch (e) {
      emit(PlayerError('update_player_error'));
    }
  }
}
