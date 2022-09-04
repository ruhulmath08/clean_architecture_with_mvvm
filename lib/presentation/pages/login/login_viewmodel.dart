import 'dart:async';

import 'package:clean_architecture_with_mvvm/domain/use_cases/login_usecase.dart';
import 'package:clean_architecture_with_mvvm/presentation/base/base_viewmodel.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/freezed_date_class.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllImputesValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase; //ToDo: have to remove ? sign

  LoginViewModel(this._loginUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  //inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllImputesValidStreamController.close();
  }

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllImputesValidStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.username, loginObject.password),
    ))
        .fold(
      (failure) => {
        //left -> failure
        print(failure.message),
      },
      (data) => {
        //right -> success (data)
        print(data.customer?.name),
      },
    );
  }

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    //data class operation same as kotlin data class
    loginObject = loginObject.copyWith(username: userName);
    _validData();
  }

  //outputs
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validData();
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

  @override
  // TODO: implement outputIsAllImputesValid
  Stream<bool> get outputIsAllImputesValid =>
      _isAllImputesValidStreamController.stream.map(
        (_) => _isAllInputValid(),
      );

  //private functions
  _validData() {
    inputIsAllInputValid.add(null);
  }

  bool _isUsernameValid(String username) {
    print('Username: ${username.isNotEmpty}');
    return username.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    print('Username: ${password.isNotEmpty}');
    return password.isNotEmpty;
  }

  bool _isAllInputValid() {
    print(
      'Username-Password: ${(_isUsernameValid(loginObject.username) && _isPasswordValid(loginObject.password))}',
    );
    return _isUsernameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password);
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

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUsernameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllImputesValid;
}
