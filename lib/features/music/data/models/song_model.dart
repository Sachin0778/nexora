import 'package:nexora/features/music/domain/entities/song_entity.dart';

class SongModel extends SongEntity {
  const SongModel({
    required super.id,
    required super.title,
    required super.artist,
    super.streamUrl,
    super.localPath,
    super.coverUrl,
  });

  factory SongModel.fromJamendoJson(Map<String, dynamic> json) {
    return SongModel(
      id: (json['id'] ?? '').toString(),
      title: (json['name'] ?? 'Untitled').toString(),
      artist: (json['artist_name'] ?? 'Unknown artist').toString(),
      streamUrl: json['audio']?.toString(),
      coverUrl: json['image']?.toString(),
    );
  }
}
