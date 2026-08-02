import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nexora/core/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(initializerName: 'initGetIt')
Future<void> configureDependencies() async {
  getIt.initGetIt();
}
