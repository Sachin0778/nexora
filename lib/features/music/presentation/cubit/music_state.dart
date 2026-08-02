import 'package:nexora/features/music/domain/entities/song_entity.dart';

enum MusicSource { offline, online }

class MusicState {
  const MusicState({
    required this.isLoading,
    required this.errorMessage,
    required this.offlineSongs,
    required this.onlineSongs,
    required this.currentSong,
    required this.isPlaying,
    required this.source,
    required this.position,
    required this.duration,
  });

  const MusicState.initial()
      : isLoading = false,
        errorMessage = null,
        offlineSongs = const [],
        onlineSongs = const [],
        currentSong = null,
        isPlaying = false,
        source = MusicSource.offline,
        position = Duration.zero,
        duration = Duration.zero;

  final bool isLoading;
  final String? errorMessage;
  final List<SongEntity> offlineSongs;
  final List<SongEntity> onlineSongs;
  final SongEntity? currentSong;
  final bool isPlaying;
  final MusicSource source;
  final Duration position;
  final Duration duration;

  List<SongEntity> get activeSongs =>
      source == MusicSource.offline ? offlineSongs : onlineSongs;

  MusicState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    List<SongEntity>? offlineSongs,
    List<SongEntity>? onlineSongs,
    SongEntity? currentSong,
    bool clearCurrentSong = false,
    bool? isPlaying,
    MusicSource? source,
    Duration? position,
    Duration? duration,
  }) {
    return MusicState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      offlineSongs: offlineSongs ?? this.offlineSongs,
      onlineSongs: onlineSongs ?? this.onlineSongs,
      currentSong:
          clearCurrentSong ? null : (currentSong ?? this.currentSong),
      isPlaying: isPlaying ?? this.isPlaying,
      source: source ?? this.source,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}
