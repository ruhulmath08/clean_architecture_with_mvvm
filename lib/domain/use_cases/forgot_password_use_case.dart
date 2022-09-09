import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_cases/base_usecase.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase implements BaseUseCase {
  ForgotPasswordUseCase(this._repository);

  final Repository _repository;

  @override
  Future<Either<Failure, dynamic>> execute(input) async {
    return await _repository.forgotPassword(input);
  }
}
