import 'package:clean_architecture_with_mvvm/presentation/pages/forget_password/forget_password_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/login/login_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/main/main_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/onboarding/onboarding_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/registration/registration_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/splash/splash_view.dart';
import 'package:clean_architecture_with_mvvm/presentation/pages/undefined_view/undefined_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegistrationView(),
        );
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordView(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (_) => const MainView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const UndefinedView(),
        );
    }
  }
}
