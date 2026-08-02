import 'package:nexora/features/music/domain/entities/song_entity.dart';

abstract class MusicRepository {
  Future<List<SongEntity>> fetchOfflineSongs();
  Future<List<SongEntity>> fetchOnlineSongs();
}
