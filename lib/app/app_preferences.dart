import 'package:clean_architecture_with_mvvm/presentation/manager/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String pressKeyLang = 'press_key_lang';
const String pressKeyOnBoardingScreen = 'press_key_on_boarding_screen';
const String pressKeyIsUserLoggedIn = 'press_key_is_user_logged_in';

class AppPreferences {
  AppPreferences(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(pressKeyLang);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(pressKeyOnBoardingScreen, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
   return _sharedPreferences.getBool(pressKeyOnBoardingScreen) ?? false;
  }

  Future<void> setIsUserLoggedIn() async {
    _sharedPreferences.setBool(pressKeyIsUserLoggedIn, true);
  }

  Future<bool> isIsUserLoggedIn() async {
   return _sharedPreferences.getBool(pressKeyIsUserLoggedIn) ?? false;
  }
}
