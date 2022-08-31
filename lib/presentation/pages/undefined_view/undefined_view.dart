import 'package:clean_architecture_with_mvvm/presentation/manager/string_manager.dart';
import 'package:flutter/material.dart';

class UndefinedView extends StatefulWidget {
  const UndefinedView({Key? key}) : super(key: key);

  @override
  State<UndefinedView> createState() => _UndefinedViewState();
}

class _UndefinedViewState extends State<UndefinedView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppString.noRouteFound),
        ),
        body: const Center(
          child: Text(AppString.noRouteFound),
        ),
      ),
    );
  }
}
