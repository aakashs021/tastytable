import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/presentation/cubit/g_cubit.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_italian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_text_cubit_italian.dart';
import 'package:tastytable/native_splash_screen.dart';
import 'package:tastytable/router/app_router.dart';
import 'package:tastytable/core/configs/theme/app_theme.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tastytable/firebase_options.dart';
import 'package:tastytable/service_locator.dart';

void main(List<String> args) async {
  NativeSplashScreen.showSplash();
  await dotenv.load(fileName: '.env');
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
    final GoRouter router = AppRouter.router;
    NativeSplashScreen.removeSplash();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GoogleSignInCubit(),
          ),
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(
            create: (context) => ViewAllPageTextCubitItalian(),
          ),
          BlocProvider(
            create: (context) => ViewAllPageTextCubitBritish(),
          ),
          BlocProvider(
            create: (context) => ViewAllPageTextCubitIndian(),
          ),
          BlocProvider(
            create: (context) => RecipeCubitItalian(),
          ),
          BlocProvider(
            create: (context) => RecipesCubitBritish(),
          ),
          BlocProvider(
            create: (context) => RecipesCubitIndian(),
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ));
  }
}
