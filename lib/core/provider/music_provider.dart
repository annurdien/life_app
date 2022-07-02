import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:life_app/models/relief_model.dart';

import '../../providers.dart';

part 'music_provider.freezed.dart';

final musicsProvider =
    FutureProvider.autoDispose<List<ReliefModel>>((ref) async {
  final client = ref.watch(appQueryProvider);

  final response = await client.getMusics();

  return (response ?? []).map((e) => ReliefModel.fromJson(e)).toList();
});

final audioPlayerProvider = Provider.autoDispose<AudioPlayer>((ref) {
  return AudioPlayer();
});

final audioPlayerControllerProvider = StateNotifierProvider.autoDispose
    .family<MusicPlayerController, AudioPlayerState, String>((ref, url) {
  final audioPlayer = ref.watch(audioPlayerProvider);

  return MusicPlayerController(audioPlayer, url, ref.read);
});

final currentMusicDurationProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

final bufferedMusicDurationProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

final totalMusicDurationProvider = StateProvider<Duration>((ref) {
  return Duration.zero;
});

class MusicPlayerController extends StateNotifier<AudioPlayerState> {
  MusicPlayerController(this.player, this.url, this.read)
      : super(const AudioPlayerState.idle()) {
    _init();
  }

  final AudioPlayer player;
  final Reader read;
  final String url;

  void _init() async {
    state = const AudioPlayerState.loading();

    try {
      await player.setUrl(url);
    } catch (e) {
      state = const AudioPlayerState.error("Error loading music");
    }

    player.playerStateStream.listen(
      (event) {
        if (!event.playing) {
          switch (event.processingState) {
            case ProcessingState.idle:
              state = const AudioPlayerState.idle();
              break;
            case ProcessingState.loading:
              state = const AudioPlayerState.loading();
              break;
            case ProcessingState.buffering:
              state = const AudioPlayerState.buffering();
              break;
            case ProcessingState.ready:
              state = const AudioPlayerState.ready();
              break;
            case ProcessingState.completed:
              state = const AudioPlayerState.completed();
              break;
          }
        } else {
          state = const AudioPlayerState.playing();
        }
      },
    );

    player.positionStream.listen((position) {
      read(currentMusicDurationProvider.notifier).state = position;
    });

    player.bufferedPositionStream.listen((bufferedPosition) {
      read(bufferedMusicDurationProvider.notifier).state = bufferedPosition;
    });

    player.durationStream.listen((totalDuration) {
      read(totalMusicDurationProvider.notifier).state =
          totalDuration ?? Duration.zero;
    });

    return;
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}

@freezed
class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState.idle() = _AudioPlayerIdleState;
  const factory AudioPlayerState.loading() = _AudioPlayerLoadingState;
  const factory AudioPlayerState.buffering() = _AudioPlayerBufferingState;
  const factory AudioPlayerState.ready() = _AudioPlayerReadyState;
  const factory AudioPlayerState.completed() = _AudioPlayerCompletedState;
  const factory AudioPlayerState.playing() = _AudioPlayerPlayingState;
  const factory AudioPlayerState.error(String error) = _AudioPlayerErrorState;
}
