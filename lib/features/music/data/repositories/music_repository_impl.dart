import 'package:injectable/injectable.dart';
import 'package:nexora/features/music/data/datasources/music_local_datasource.dart';
import 'package:nexora/features/music/data/datasources/music_remote_datasource.dart';
import 'package:nexora/features/music/domain/entities/song_entity.dart';
import 'package:nexora/features/music/domain/repositories/music_repository.dart';

@LazySingleton(as: MusicRepository)
class MusicRepositoryImpl implements MusicRepository {
  MusicRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final MusicLocalDataSource _localDataSource;
  final MusicRemoteDataSource _remoteDataSource;

  @override
  Future<List<SongEntity>> fetchOfflineSongs() {
    return _localDataSource.fetchDeviceSongs();
  }

  @override
  Future<List<SongEntity>> fetchOnlineSongs() {
    return _remoteDataSource.fetchJamendoTracks();
  }
}
