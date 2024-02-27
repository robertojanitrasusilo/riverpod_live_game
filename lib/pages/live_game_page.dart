import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:live_game_riverpod/models/game.dart';
import 'package:live_game_riverpod/providers/genre_provider.dart';
import 'package:live_game_riverpod/providers/live_game_provider.dart';

class LiveGamePage extends ConsumerStatefulWidget {
  const LiveGamePage({super.key});

  @override
  ConsumerState<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends ConsumerState<LiveGamePage> {
  List<String> genres = [
    "Shooter",
    "MMORPG",
    "ARPG",
    "Strategy",
    "Fighting",
  ];
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(liveGameNotifierProvider.notifier).fetchLiveGame();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Live Game'),
        ),
        body: Column(
          children: [
            Consumer(builder: (context, wiRef, child) {
              String widgetSelected = wiRef.watch(genreNotifierProvider);
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                      children: genres
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ActionChip(
                                    color: MaterialStateProperty.resolveWith(
                                        (states) => widgetSelected == e
                                            ? Colors.blue
                                            : Colors.black),
                                    onPressed: () {
                                      wiRef
                                          .read(genreNotifierProvider.notifier)
                                          .changeGenre(e);
                                    },
                                    label: Text(e)),
                              ))
                          .toList()),
                ),
              );
            }),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer(
                builder: (context, wiRef, child) {
                  LiveGameState state = wiRef.watch(liveGameNotifierProvider);
                  if (state.status == '') return const SizedBox.shrink();
                  if (state.status == 'loading') {
                    return const CircularProgressIndicator();
                  }
                  if (state.status == 'error') {
                    return Center(child: Text(state.message));
                  }
                  List<Game> list = state.games;
                  String widgetSelected = wiRef.watch(genreNotifierProvider);
                  List<Game> games = list
                      .where((element) => element.genre == widgetSelected)
                      .toList();
                  return GridView.builder(
                      itemCount: games.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        Game game = games[index];
                        return Stack(children: [
                          Positioned.fill(
                            child: ExtendedImage.network(
                              game.thumbnail,
                              fit: BoxFit.cover,
                              cache: true,
                            ),
                          ),
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5)
                                  ])),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    onPressed: () {
                                      wiRef
                                          .read(
                                              liveGameNotifierProvider.notifier)
                                          .changeSavedStatus(game.copyWith(
                                              isSaved: !game.isSaved));
                                    },
                                    icon: Icon(
                                      game.isSaved
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    )),
                              )),
                        ]);
                      });
                },
              ),
            ),
          ],
        ));
  }
}
