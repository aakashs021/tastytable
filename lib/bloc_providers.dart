import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_theme.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:tastytable/features/auth/presentation/cubit/g_cubit.dart';
import 'package:tastytable/features/detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/recipes/recipes_cubit_italian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_british.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_cubit_indian.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_text_cubit_italian.dart';
import 'package:tastytable/features/search/presentation/bloc/search_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20account%20bloc/delete_account_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20google%20account/delete_google_account_bloc.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_bloc.dart';
import 'package:tastytable/features/settings/presentation/cubit/change_password_cubit.dart';
import 'package:tastytable/features/settings/presentation/cubit/theme_cubit.dart';

MultiBlocProvider blocProvider({required GoRouter router}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
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
        ),
        BlocProvider(
          create: (context) => ChangePasswordCubit(),
        ),
        BlocProvider(create: (context) => RecipeDetailBloc(),),
        BlocProvider(create: (context) => SearchBloc(),),
        BlocProvider(create: (context) => DeleteAccountBloc(),),
        BlocProvider(create: (context) => DeleteGoogleAccountBloc(),)
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, thememode) {
          return MaterialApp.router(
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: thememode,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ));
}
