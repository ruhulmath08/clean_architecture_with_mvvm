import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_with_mvvm/data/repositories/repository_impl.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_cases/login_usecase.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/assets_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/routes_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/value_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/login/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final LoginViewModel _loginViewModel = instance<LoginViewModel>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _bind() {
    _loginViewModel.start();
    _userNameController.addListener(
      () => _loginViewModel.setUserName(_userNameController.text.trim()),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(_passwordController.text),
    );
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p14),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Image(image: AssetImage(ImageAssets.splashLogo)),
                const SizedBox(height: AppSize.s28),
                _usernameFormField(),
                const SizedBox(height: AppSize.s20),
                _passwordFormField(),
                const SizedBox(height: AppSize.s20),
                _loginButton(),
                const SizedBox(height: AppSize.s20),
                _forgetPasswordAndSignInOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _usernameFormField() {
    return StreamBuilder<bool>(
      stream: _loginViewModel.outputIsUsernameValid,
      builder: (context, snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _userNameController,
          decoration: InputDecoration(
            hintText: AppString.username,
            labelText: AppString.username,
            errorText: (snapshot.data ?? true) ? null : AppString.usernameError,
          ),
        );
      },
    );
  }

  Widget _passwordFormField() {
    return StreamBuilder<bool>(
      stream: _loginViewModel.outputIsPasswordValid,
      builder: (context, snapshot) {
        return TextFormField(
          keyboardType: TextInputType.name,
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: AppString.password,
            labelText: AppString.password,
            errorText: (snapshot.data ?? true) ? null : AppString.passwordWrong,
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    return StreamBuilder<bool>(
      stream: _loginViewModel.outputIsAllImputesValid,
      builder: (context, snapshot) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s40,
          child: ElevatedButton(
            onPressed: (snapshot.data ?? false)
                ? () {
                    _loginViewModel.login();
                  }
                : null,
            child: const Text(AppString.login),
          ),
        );
      },
    );
  }

  Widget _forgetPasswordAndSignInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                Routes.forgetPasswordRoute,
              );
            },
            child: Text(
              AppString.forgetPassword,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                Routes.forgetPasswordRoute,
              );
            },
            child: Text(
              AppString.memberSignUp,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      ],
    );
  }
}
