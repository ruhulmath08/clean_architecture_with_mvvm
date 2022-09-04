import 'package:clean_architecture_with_mvvm/app/app_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initialAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //SharedPreferences instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance<SharedPreferences>()));
}

// RemoteDataSource _remoteDataSource =
//     RemoteDataSourceImplementations(_appServiceClient);
// Repository _repository = RepositoryImpl(_remoteDataSource, _networkInfo);
// LoginUseCase loginUseCase = LoginUseCase(_repository);
