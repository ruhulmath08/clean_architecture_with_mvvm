import 'package:clean_architecture_with_mvvm/app/function.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/domain/entities/model.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_cases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  LoginUseCase(this._repository);

  final Repository _repository;

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(
      LoginRequest(
        input.email,
        input.password,
        deviceInfo.identifier,
        deviceInfo.name,
      ),
    );
  }
}

class LoginUseCaseInput {
  LoginUseCaseInput(this.email, this.password);

  String email;
  String password;
}
