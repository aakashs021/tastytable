import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static late ThemeCubit instance; // Static instance

  ThemeCubit() : super(ThemeMode.light) {
    instance = this;
  }

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  bool isDarkMode() => state == ThemeMode.dark;
}
