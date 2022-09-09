import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_render_impl.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/assets_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/value_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/forget_password/forgot_password_viewmodel.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final ForgotPasswordViewModel _forgotPasswordViewModel =
      instance<ForgotPasswordViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _forgotPasswordViewModel.start();
    _emailTextEditingController.addListener(() =>
        _forgotPasswordViewModel.setEmail(_emailTextEditingController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _forgotPasswordViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),
                  () {
                    _forgotPasswordViewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p47),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSize.s70),
            const Image(image: AssetImage(ImageAssets.splashLogo)),
            _emailFormField(context),
            const SizedBox(height: AppSize.s70),
            _loginButton(),
            const SizedBox(height: AppSize.s22),
            _resetEmailTextButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailFormField(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _forgotPasswordViewModel.outputIsEmailValid,
      builder: (context, snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailTextEditingController,
          decoration: InputDecoration(
            hintText: AppString.email,
            labelText: AppString.email,
            errorText: (snapshot.data ?? true) ? null : AppString.emailError,
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    return StreamBuilder<bool>(
      stream: _forgotPasswordViewModel.outputIsAllInputValid,
      builder: (context, snapshot) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s40,
          child: ElevatedButton(
            onPressed: (snapshot.data ?? false)
                ? () => _forgotPasswordViewModel.forgotPassword()
                : null,
            child: const Text(AppString.resetPassword),
          ),
        );
      },
    );
  }

  Widget _resetEmailTextButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        AppString.resendEmail,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
