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
import 'package:tastytable/features/settings/presentation/bloc/user_name_bloc.dart';
import 'package:tastytable/native_splash_screen.dart';
import 'package:tastytable/router/app_router.dart';
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
          BlocProvider(
            create: (context) => UserNameBloc(),
          )
        ],
        child: MaterialApp.router(
          // darkTheme: darkTheme,
          theme: lightTheme,
          // themeMode: ThemeMode.system,
          // theme: ThemeData(
          //     scaffoldBackgroundColor: Colors.white,
          //     primaryColor: Colors.white,
          //     appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          //     dialogTheme: DialogTheme(backgroundColor: Colors.white,),
          //     dialogBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ));
  }
}

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blue, // Adjust for your primary theme color
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black), // AppBar icon color
    titleTextStyle: TextStyle(color: Colors.black), // AppBar title color
  ),
  dialogTheme: DialogTheme(backgroundColor: Colors.white),
  dialogBackgroundColor: Colors.white,
  // textTheme: TextTheme(
  //   bodyText1: TextStyle(color: Colors.black),
  //   bodyText2: TextStyle(color: Colors.black),
  //   headline1: TextStyle(color: Colors.black),
  //   headline2: TextStyle(color: Colors.black),
  //   headline3: TextStyle(color: Colors.black),
  //   subtitle1: TextStyle(color: Colors.black),
  //   subtitle2: TextStyle(color: Colors.black),
  // ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue, // Default button color for light theme
    textTheme: ButtonTextTheme.primary,
  ),
  // Define more theme elements like InputDecorationTheme for text fields, etc.
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.blueGrey, // Adjust dark theme primary color
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white), // AppBar icon color
    titleTextStyle: TextStyle(color: Colors.white), // AppBar title color
  ),
  dialogTheme: DialogTheme(backgroundColor: Colors.black),
  dialogBackgroundColor: Colors.black,
  // textTheme: TextTheme(
  //   bodyText1: TextStyle(color: Colors.white),
  //   bodyText2: TextStyle(color: Colors.white),
  //   headline1: TextStyle(color: Colors.white),
  //   headline2: TextStyle(color: Colors.white),
  //   headline3: TextStyle(color: Colors.white),
  //   subtitle1: TextStyle(color: Colors.white),
  //   subtitle2: TextStyle(color: Colors.white),
  // ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueGrey, // Default button color for dark theme
    textTheme: ButtonTextTheme.primary,
  ),
  // Customize dark theme input fields, sliders, etc.
);
