import 'package:clean_architecture_with_mvvm/app/constant.dart';
import 'package:clean_architecture_with_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/string_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

//Loading state (POPUP, FULL SCREEN)
class LoadingState extends FlowState {
  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppString.loading;

  StateRendererType stateRendererType;
  String message;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error state (POPUP, FULL LOADING)
class ErrorState extends FlowState {
  ErrorState(this.stateRendererType, this.message);

  StateRendererType stateRendererType;
  String message;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

//empty state
class EmptyState extends FlowState {
  EmptyState(this.message);

  String message;

  @override
  String getMessage() => Constant.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
    BuildContext context,
    Widget contentScreenWidget,
    Function reTryActionFunctions,
  ) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          //showing popup dialog
          showPopUp(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          //StateRendererType.fullScreenLoadingState
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: reTryActionFunctions,
          );
        }

      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          //showing popup dialog
          showPopUp(context, getStateRendererType(), getMessage());
          return contentScreenWidget;
        } else {
          //StateRendererType.fullScreenErrorState
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: reTryActionFunctions,
          );
        }

      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;

      case EmptyState:
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryActionFunction: reTryActionFunctions,
        );

      default:
        return contentScreenWidget;
    }
  }
}

dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

_isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

showPopUp(
  BuildContext context,
  StateRendererType stateRendererType,
  String message,
) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => showDialog(
      context: context,
      builder: (BuildContext context) => StateRenderer(
        stateRendererType: stateRendererType,
        message: message,
        retryActionFunction: () {},
      ),
    ),
  );
}
