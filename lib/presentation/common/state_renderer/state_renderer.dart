import 'package:clean_architecture_with_mvvm/app/constant.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/assets_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/color_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/font_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/string_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/style_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //popup state
  popupLoadingState,
  popupErrorState,
  popupSuccess,
  //full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, //the UI of the screen
  emptyScreenState //empty view when we receive no data from API side
}

class StateRenderer extends StatelessWidget {
  StateRenderer({
    Key? key,
    required this.stateRendererType,
    required this.retryActionFunction,
    String? message,
    String? title,
  })  : message = message ?? AppString.loading,
        title = title ?? Constant.empty,
        super(key: key);

  StateRendererType stateRendererType;
  Function? retryActionFunction;
  String message;
  String title;

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(context, [_getAnimatedImage(JsonAsset.loading)]);

      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAsset.error),
          _getMessage(message),
          _getRetryButton(AppString.ok, context),
        ]);

      case StateRendererType.popupSuccess:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAsset.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppString.ok, context),
        ]);

      case StateRendererType.fullScreenLoadingState:
        return _getItemInColumn([
          _getAnimatedImage(JsonAsset.loading),
          _getMessage(message),
        ]);

      case StateRendererType.fullScreenErrorState:
        return _getItemInColumn(
          [
            _getAnimatedImage(JsonAsset.error),
            _getMessage(message),
            _getRetryButton(AppString.reTryAgain, context),
          ],
        );

      case StateRendererType.contentScreenState:
        return Container();

      case StateRendererType.emptyScreenState:
        return _getItemInColumn(
          [_getAnimatedImage(JsonAsset.empty), _getMessage(message)],
        );

      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(AppSize.s0, AppSize.s12),
            ),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      width: AppSize.s100,
      height: AppSize.s100,
      child: Lottie.asset(animationName), //json image
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonStyle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.fullScreenErrorState) {
                //to call the API function again
                retryActionFunction?.call();
              } else {
                //popup state error so we dismiss the dialog
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonStyle),
          ),
        ),
      ),
    );
  }

  Widget _getItemInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
