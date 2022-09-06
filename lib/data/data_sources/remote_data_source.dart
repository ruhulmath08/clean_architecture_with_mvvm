import 'package:clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementations implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementations(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      '', //ToDo: have to pass -> loginRequest.imei
      '', //ToDo: have to pass -> loginRequest.deviceType
    );
  }
}
