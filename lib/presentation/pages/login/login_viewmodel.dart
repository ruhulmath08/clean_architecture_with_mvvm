import 'dart:async';

import 'package:clean_architecture_with_mvvm/presentation/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  @override
  void start() {
    // TODO: implement start
  }

  //inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  //outputs
  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  // TODO: implement outputIsUsernameValid
  Stream<bool> get outputIsUsernameValid =>
      _userNameStreamController.stream.map(
        (username) => _isUsernameValid(username),
      );

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid =>
      _passwordStreamController.stream.map(
        (password) => _isPasswordValid(password),
      );

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty && password.length > 6;
  }
}

abstract class LoginViewModelInputs {
  //three functions
  setUserName(String userName);

  setPassword(String password);

  login();

  //two sinks for streams
  Sink get inputUsername;

  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;

  Stream<bool> get outputIsPasswordValid;
}
