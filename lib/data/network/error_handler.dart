import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaults,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio error so its error from response of the API
      failure = _handleError(error);
    } else {
      //default error
      failure = DataSource.defaults.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeOut.getFailure();

      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();

      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();

          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();

          case ResponseCode.unAuthorised:
            return DataSource.unAuthorised.getFailure();

          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();

          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();

          default:
            return DataSource.defaults.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.connectTimeOut.getFailure();

      case DioErrorType.other:
        return DataSource.defaults.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);

      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);

      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);

      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);

      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);

      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);

      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);

      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);

      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);

      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);

      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.cacheError);

      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);

      case DataSource.defaults:
        return Failure(ResponseCode.defaults, ResponseMessage.defaults);

      default:
        return Failure(ResponseCode.defaults, ResponseMessage.defaults);
    }
  }
}

class ResponseCode {
  //API status code
  static const int success = 200; //success with data
  static const int noContent = 201; //success with no content
  static const int badRequest = 400; //failure, API rejected request
  static const int forbidden = 403; //failure, API rejected request
  static const int unAuthorised = 401; //failure, API is not authenticate
  static const int notFound = 404; //failure, url is not correct and not found
  static const int internalServerError = 500; //failure, internal server error

  //local status code
  static const int defaults = -1;
  static const int connectTimeOut = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  //API status code
  static const String success = 'Success';
  static const String noContent = 'Success with no content';
  static const String badRequest = 'Bad request, try again later';
  static const String forbidden = 'Forbidden request, try again later';
  static const String unAuthorised = 'User is unauthorised, try again later';
  static const String notFound = 'URL is not found, try again later';
  static const String internalServerError =
      'Something went wrong, try again later';

  //local status code
  static const String defaults = 'Something went wrong, try again later';
  static const String connectTimeOut = 'Time out error, try again later';
  static const String cancel = 'Request was cancelled, try again later';
  static const String receiveTimeout = 'Time out error, try again later';
  static const sendTimeout = 'Time out error, try again later';
  static const String cacheError = 'Cache error, try again later';
  static const String noInternetConnection =
      'Please check your internet connection';
}

class ApiInternalStatus{
  static const int success = 200;
  static const int failure = 1;
}
