import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assistant_methode/hivebase.dart';

/// Theme Mode Cubit is to switch between Light and Dark Mode
class AppLanguageCubit extends Cubit<String> {
  /// initial Language
  AppLanguageCubit(String initialLanguage) : super(initialLanguage);

  /// set Language
  Future<void> setAppLanguage(String language) async {
    HiveBase.hiveBase.setLanguage(language);

    emit(language);
  }

  @override
  String toString() => "English";
}
