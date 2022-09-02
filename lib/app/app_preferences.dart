import 'package:clean_architecture_with_mvvm/presentation/manager/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String pressKeyLang = 'press_key_lang';

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
}
