import 'package:clean_architecture_with_mvvm/data/network/error_handler.dart';

class Failure {
  int code; //200 or 400
  String message;

  Failure(this.code, this.message); //error or success
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.defaults, ResponseMessage.defaults);
}
