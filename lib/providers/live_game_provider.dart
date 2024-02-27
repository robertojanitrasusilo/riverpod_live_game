import 'package:equatable/equatable.dart';
import 'package:live_game_riverpod/models/game.dart';
import 'package:live_game_riverpod/source/game_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_game_provider.g.dart';

@Riverpod(keepAlive: false)
class LiveGameNotifier extends _$LiveGameNotifier {
  @override
  LiveGameState build() {
    return const LiveGameState(
      status: '',
      message: '',
      games: [],
    );
  }

  fetchLiveGame() async {
    state = const LiveGameState(
      status: 'Loading',
      message: 'Please wait',
      games: [],
    );
    final games = await GameSource.getLive();
    if (games == null) {
      return state = const LiveGameState(
          status: 'Error', message: 'Data not found', games: []);
    }
    state =
        LiveGameState(status: 'Success', message: 'Data got it', games: games);
  }

  void changeSavedStatus(Game newGame) {
    int index = state.games.indexWhere((game) => game.id == newGame.id);
    state.games[index] = newGame;
    state = LiveGameState(
      status: "Success",
      message: state.message,
      games: [...state.games],
    );
  }
}

class LiveGameState extends Equatable {
  final String status;
  final String message;
  final List<Game> games;

  const LiveGameState({
    required this.status,
    required this.message,
    required this.games,
  });
  @override
  // TODO: implement props
  List<Object> get props => [status, message, games];
}
