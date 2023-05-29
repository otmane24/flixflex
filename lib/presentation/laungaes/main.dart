import 'english_strings.dart';

import 'global_strings.dart';

class AppLanguage {
  static late GlobalStrings strings;

  static setStrings(String language) {
    switch (language) {
      case "En":
        strings = EnglishStrings();
        break;
      default:
        strings = EnglishStrings();
    }
  }
}
