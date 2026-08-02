import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nexora/features/music/domain/entities/song_entity.dart';
import 'package:nexora/features/music/domain/repositories/music_repository.dart';
import 'package:nexora/features/music/presentation/cubit/music_state.dart';
import 'package:nexora/features/music/presentation/services/audio_player_service.dart';

@injectable
class MusicCubit extends Cubit<MusicState> {
  MusicCubit(
    this._musicRepository,
    this._audioPlayerService,
  ) : super(const MusicState.initial()) {
    _playingSubscription = _audioPlayerService.playingStream.listen((playing) {
      emit(state.copyWith(isPlaying: playing));
    });

    _positionSubscription = _audioPlayerService.positionStream.listen((value) {
      emit(state.copyWith(position: value));
    });

    _durationSubscription = _audioPlayerService.durationStream.listen((value) {
      emit(state.copyWith(duration: value ?? Duration.zero));
    });
  }

  final MusicRepository _musicRepository;
  final AudioPlayerService _audioPlayerService;
  StreamSubscription<bool>? _playingSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  Future<void> initialize() async {
    await loadOfflineSongs();
  }

  Future<void> changeSource(MusicSource source) async {
    emit(state.copyWith(source: source, clearError: true));
    if (source == MusicSource.offline) {
      await loadOfflineSongs();
    } else {
      await loadOnlineSongs();
    }
  }

  Future<void> loadOfflineSongs() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final songs = await _musicRepository.fetchOfflineSongs();
      emit(
        state.copyWith(
          isLoading: false,
          offlineSongs: songs,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to load offline songs',
        ),
      );
    }
  }

  Future<void> loadOnlineSongs() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final songs = await _musicRepository.fetchOnlineSongs();
      emit(
        state.copyWith(
          isLoading: false,
          onlineSongs: songs,
          clearError: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage:
              'Unable to load online songs. Check Jamendo client id and network.',
        ),
      );
    }
  }

  Future<void> playSong(SongEntity song) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      if (song.localPath != null && song.localPath!.isNotEmpty) {
        await _audioPlayerService.playFile(song.localPath!);
      } else if (song.streamUrl != null && song.streamUrl!.isNotEmpty) {
        await _audioPlayerService.playUrl(song.streamUrl!);
      } else {
        throw Exception('No playable source found');
      }

      emit(
        state.copyWith(
          isLoading: false,
          currentSong: song,
          isPlaying: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to play selected song',
        ),
      );
    }
  }

  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await _audioPlayerService.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      await _audioPlayerService.resume();
      emit(state.copyWith(isPlaying: true));
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayerService.seek(position);
  }

  @override
  Future<void> close() async {
    await _playingSubscription?.cancel();
    await _positionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _audioPlayerService.dispose();
    return super.close();
  }
}
