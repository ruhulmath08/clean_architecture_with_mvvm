import 'dart:async';

import 'package:clean_architecture_with_mvvm/app/function.dart';
import 'package:clean_architecture_with_mvvm/domain/use_cases/forgot_password_use_case.dart';
import 'package:clean_architecture_with_mvvm/presentation/base/base_viewmodel.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_renderer.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = '';

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  @override
  forgotPassword() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );
    (await _forgotPasswordUseCase.execute(email)).fold(
      (failure) => {
        inputState.add(
          ErrorState(StateRendererType.popupErrorState, failure.message),
        )
      },
      (supportMessage) => {
        inputState.add(SuccessState(supportMessage)),
      },
    );
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  // TODO: implement outputIsAllInputValid
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream.map(
        (isAllInputValid) => _isAllInputValid(),
      );

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInput {
  void forgotPassword();

  void setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
