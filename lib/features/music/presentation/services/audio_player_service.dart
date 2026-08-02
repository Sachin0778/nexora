import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

@lazySingleton
class AudioPlayerService {
  AudioPlayer? _player;

  AudioPlayer get _audioPlayer => _player ??= AudioPlayer();

  Stream<bool> get playingStream => _audioPlayer.playingStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Future<void> playUrl(String url) async {
    await _audioPlayer.setUrl(url);
    await _audioPlayer.play();
  }

  Future<void> playFile(String path) async {
    await _audioPlayer.setFilePath(path);
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    if (_player == null) return;
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    if (_player == null) return;
    await _audioPlayer.play();
  }

  Future<void> seek(Duration position) async {
    if (_player == null) return;
    await _audioPlayer.seek(position);
  }

  Future<void> stop() async {
    if (_player == null) return;
    await _audioPlayer.stop();
  }

  Future<void> dispose() async {
    if (_player == null) return;
    await _audioPlayer.dispose();
    _player = null;
  }
}
