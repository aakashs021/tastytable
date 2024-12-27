import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class NativeSplashScreen {
 static showSplash(){
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
 static removeSplash(){
          FlutterNativeSplash.remove();

  }
}