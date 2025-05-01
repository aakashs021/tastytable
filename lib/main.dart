import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/bloc_providers.dart';
import 'package:tastytable/core/utils/shared%20preference/api_preference.dart';
import 'package:tastytable/core/utils/shared%20preference/dark_theme_preference.dart';
import 'package:tastytable/native_splash_screen.dart';
import 'package:tastytable/router/app_router.dart';
import 'package:tastytable/firebase_options.dart';
import 'package:tastytable/service_locator.dart';

void main(List<String> args) async {
  NativeSplashScreen.showSplash();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DarkThemePreference.init();
  await ApiPreference.init();
  await ServiceLocator.initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.router;
    NativeSplashScreen.removeSplash();
    return blocProvider(router: router);
  }
}
