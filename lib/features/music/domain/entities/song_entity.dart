class SongEntity {
  const SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    this.streamUrl,
    this.localPath,
    this.coverUrl,
  });

  final String id;
  final String title;
  final String artist;
  final String? streamUrl;
  final String? localPath;
  final String? coverUrl;
}
