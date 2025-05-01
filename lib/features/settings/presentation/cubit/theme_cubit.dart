import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/core/configs/theme/app_theme.dart';
import 'package:tastytable/core/utils/shared%20preference/dark_theme_preference.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static late ThemeCubit instance; // Static instance

  ThemeCubit() : super(ThemeMode.light) {
    _loadThemePreference();
    instance=this;
  }
   Future<void> _loadThemePreference() async {
    bool? isDarkMode = await DarkThemePreference.getDarkTheme();
    if(isDarkMode!=null){
    emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    }else{
      emit(ThemeMode.light);
    }
  }

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
         DarkThemePreference.setDarkModeData(isDarkMode: state == ThemeMode.dark);

  }

  bool isDarkMode() => state == ThemeMode.dark;
}
