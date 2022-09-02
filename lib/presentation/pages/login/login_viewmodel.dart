import 'package:clean_architecture_with_mvvm/presentation/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  //inputes
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUsername
  Sink get inputUsername => throw UnimplementedError();

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  //outputs
  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsUsernameValid
  Stream<bool> get outputIsUsernameValid => throw UnimplementedError();
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
