import 'package:clean_architecture_with_mvvm/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_with_mvvm/data/mapper/mapper.dart';
import 'package:clean_architecture_with_mvvm/data/network/error_handler.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/domain/entities/model.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnect) {
      try {
        //safe to call the API
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          //return data
          return Right(response.toDomain());
        } else {
          //return business logic data
          return Left(
            Failure(
              response.status ?? ApiInternalStatus.failure,
              response.message ?? ResponseMessage.defaults,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async{
    if (await _networkInfo.isConnect) {
      try {
        //safe to call the API
        final response = await _remoteDataSource.forgetPassword(email);
        if (response.status == ApiInternalStatus.success) {
          //return data
          return Right(response.toDomain());
        } else {
          //return business logic data
          return Left(
            Failure(
              response.status ?? ResponseCode.defaults,
              response.message ?? ResponseMessage.defaults,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
