import 'dart:async';

import 'package:clean_architecture_with_mvvm/domain/model.dart';
import 'package:clean_architecture_with_mvvm/presentation/base/base_viewmodel.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/assets_manager.dart';
import 'package:clean_architecture_with_mvvm/presentation/manager/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controller
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //input sections
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView(); //send this slider data to our view
  }

  @override
  void goNext() {
    int nextIndex = _currentIndex++; //-1
    if (nextIndex >= _list.length) {
      //infinite loop to go to first item item inside the slider
      _currentIndex = 0;
    }
    _postDataToView();
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--; //-1
    if (previousIndex == -1) {
      //infinite loop to go to the length of slider list
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChange(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //outputs section
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //private function
  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppString.onBoardingTitle1,
          AppString.onBoardingSubTitle1,
          ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          AppString.onBoardingTitle2,
          AppString.onBoardingSubTitle2,
          ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          AppString.onBoardingTitle3,
          AppString.onBoardingSubTitle3,
          ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          AppString.onBoardingTitle4,
          AppString.onBoardingSubTitle4,
          ImageAssets.onBoardingLogo4,
        ),
      ];

  _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(_list[_currentIndex], _list.length, _currentIndex),
    );
  }
}

//inputs mean the orders that our ViewModel will receive from our View
abstract class OnBoardingViewModelInputs {
  //when user clicks on right arrow or swipe left
  void goNext();

  //when user clicks on left arrow or swipe right
  void goPrevious();

  //change the tab
  void onPageChange(int index);

  //this is the way to add data to the stream .. stream input
  Sink get inputSliderViewObject;
}

//outputs mean data or results that will be sent from our ViewModel to our View
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlide;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlide, this.currentIndex);
}
