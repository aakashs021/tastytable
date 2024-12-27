import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/presentation/cubit/g_cubit.dart';
import 'package:tastytable/native_splash_screen.dart';
import 'package:tastytable/router/app_router.dart';
import 'package:tastytable/core/configs/theme/app_theme.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/firebase_options.dart';
import 'package:tastytable/service_locator.dart';


void main(List<String> args)async {
  NativeSplashScreen.showSplash();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
await ServiceLocator.initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router= AppRouter.router;
NativeSplashScreen.removeSplash();
    return MultiBlocProvider(providers: [
BlocProvider(
        create: (context) => GoogleSignInCubit(),
      ),
      BlocProvider(
        create: (context) => AuthBloc(),
      )    ], child:  MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    ));
    
  }
}


