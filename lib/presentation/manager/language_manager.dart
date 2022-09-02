enum LanguageType { english, bengali }

const String english = 'en';
const String bengali = 'bn';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.bengali:
        return bengali;
    }
  }
}
