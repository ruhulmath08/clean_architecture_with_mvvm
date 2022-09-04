import 'package:clean_architecture_with_mvvm/app/app_preferences.dart';
import 'package:clean_architecture_with_mvvm/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:clean_architecture_with_mvvm/data/network/dio_factory.dart';
import 'package:clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:clean_architecture_with_mvvm/data/repositories/repository_impl.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_cases/login_usecase.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initialAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //SharedPreferences instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //app preferences
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance<SharedPreferences>()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementations(instance()));

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));

  //initialize login module
  initLoginModule();
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

// RemoteDataSource _remoteDataSource =
//     RemoteDataSourceImplementations(_appServiceClient);
// Repository _repository = RepositoryImpl(_remoteDataSource, _networkInfo);
// LoginUseCase loginUseCase = LoginUseCase(_repository);
