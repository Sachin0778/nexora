// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nexora/core/di/register_module.dart' as _i358;
import 'package:nexora/core/network/api_client.dart' as _i505;
import 'package:nexora/features/music/data/datasources/music_local_datasource.dart'
    as _i823;
import 'package:nexora/features/music/data/datasources/music_remote_datasource.dart'
    as _i1018;
import 'package:nexora/features/music/data/repositories/music_repository_impl.dart'
    as _i481;
import 'package:nexora/features/music/domain/repositories/music_repository.dart'
    as _i800;
import 'package:nexora/features/music/presentation/cubit/music_cubit.dart'
    as _i615;
import 'package:nexora/features/music/presentation/services/audio_player_service.dart'
    as _i14;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i14.AudioPlayerService>(() => _i14.AudioPlayerService());
    gh.lazySingleton<_i505.ApiClient>(() => _i505.ApiClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i823.MusicLocalDataSource>(
      () => _i823.MusicLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i1018.MusicRemoteDataSource>(
      () => _i1018.MusicRemoteDataSourceImpl(gh<_i505.ApiClient>()),
    );
    gh.lazySingleton<_i800.MusicRepository>(
      () => _i481.MusicRepositoryImpl(
        gh<_i823.MusicLocalDataSource>(),
        gh<_i1018.MusicRemoteDataSource>(),
      ),
    );
    gh.factory<_i615.MusicCubit>(
      () => _i615.MusicCubit(
        gh<_i800.MusicRepository>(),
        gh<_i14.AudioPlayerService>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i358.RegisterModule {}
