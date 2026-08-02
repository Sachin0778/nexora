import 'package:injectable/injectable.dart';
import 'package:nexora/core/network/api_client.dart';
import 'package:nexora/features/music/data/models/song_model.dart';

abstract class MusicRemoteDataSource {
  Future<List<SongModel>> fetchJamendoTracks();
}

@LazySingleton(as: MusicRemoteDataSource)
class MusicRemoteDataSourceImpl implements MusicRemoteDataSource {
  MusicRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<SongModel>> fetchJamendoTracks() async {
    final response = await _apiClient.get(
      'https://api.jamendo.com/v3.0/tracks',
      queryParameters: const {
        'client_id': '30f9af29',
        'format': 'json',
        'limit': 20,
        'include': 'musicinfo',
      },
    );

    final root = response.data;
    if (root is! Map<String, dynamic>) {
      return const [];
    }

    final results = root['results'];
    if (results is! List) {
      return const [];
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map(SongModel.fromJamendoJson)
        .toList();
  }
}
