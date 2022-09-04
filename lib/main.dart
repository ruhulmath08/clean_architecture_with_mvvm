import 'package:clean_architecture_with_mvvm/app/app.dart';
import 'package:clean_architecture_with_mvvm/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialAppModule();
  runApp(MyApp());
}

//upto: lecture 29

//script
/*
* Auto Generate model: flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
*
* */
