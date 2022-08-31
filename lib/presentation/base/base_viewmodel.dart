abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //share variables and functions that will be used through any view model

}

abstract class BaseViewModelInputs {
  void start(); //will be called while init of ViewModel
  void dispose(); //will be called while ViewModel will dispose
}

abstract class BaseViewModelOutputs {}
  