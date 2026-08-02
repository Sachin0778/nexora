import 'package:injectable/injectable.dart';
import 'package:nexora/features/music/data/models/song_model.dart';
import 'package:photo_manager/photo_manager.dart';

abstract class MusicLocalDataSource {
  Future<List<SongModel>> fetchDeviceSongs();
}

@LazySingleton(as: MusicLocalDataSource)
class MusicLocalDataSourceImpl implements MusicLocalDataSource {
  @override
  Future<List<SongModel>> fetchDeviceSongs() async {
    final permissionState = await PhotoManager.requestPermissionExtend();
    if (!permissionState.isAuth) {
      return const [];
    }

    final audioAlbums = await PhotoManager.getAssetPathList(
      type: RequestType.audio,
      onlyAll: true,
    );

    if (audioAlbums.isEmpty) {
      return const [];
    }

    final allAudio = <AssetEntity>[];
    for (final album in audioAlbums) {
      final count = await album.assetCountAsync;
      if (count == 0) continue;
      final tracks = await album.getAssetListRange(start: 0, end: count);
      allAudio.addAll(tracks);
    }

    final songs = <SongModel>[];
    for (final asset in allAudio) {
      final file = await asset.file;
      final path = file?.path;
      if (path == null || path.isEmpty) continue;

      songs.add(
        SongModel(
          id: asset.id,
          title: asset.title ?? 'Unknown title',
          artist: 'Local audio',
          localPath: path,
        ),
      );
    }

    return songs;
  }
}
