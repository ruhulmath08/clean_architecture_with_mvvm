import 'dart:async';

import 'package:clean_architecture_with_mvvm/app/app_preferences.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/assets_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPreferences.isIsUserLoggedIn().then(
          (isUserLoggedIn) => {
            if (isUserLoggedIn)
              {
                Navigator.pushReplacementNamed(context, Routes.onBoardingRoute),
              }
            else
              {
                _appPreferences.isOnBoardingScreenViewed().then(
                      (isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.loginRoute,
                            ),
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.onBoardingRoute,
                            ),
                          }
                      },
                    ),
              }
          },
        );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: const Center(
          child: Image(
            image: AssetImage(ImageAssets.splashLogo),
          ),
        ),
      ),
    );
  }
}
