import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/presentation/pages/view_all_page.dart';
import 'package:tastytable/router/app_router_constants.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tastytable/features/profile/presentation/pages/settings.dart';
import 'package:tastytable/features/recipes/presentation/pages/home_page.dart';

class AppRouter {
 static String initalPage(){
    if(FirebaseAuth.instance.currentUser==null){
      return '/signin';
    }else{
      return '/home';
    }
  }

  static final GoRouter router = GoRouter(
    initialLocation: initalPage(),
    routes: <RouteBase>[
      GoRoute(
        name: "settings",
        path: '/settings',
        builder: (context, state) => const SettingPage(),
      ),
      GoRoute(
        name: AppRouterConstants.homeRouteName,
        path: '/home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: AppRouterConstants.viewAllPageRouteName,
            path: '/viewAll/:title',
            builder: (context, state) => ViewAllPage(
              title: state.pathParameters['title']!,
              recipes: state.extra as List<RecipeHomeModel>,
            ),
            )
        ]
      ),
      GoRoute(
        name: AppRouterConstants.signInRouteName,
        path: "/signin",
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        name: AppRouterConstants.signUpRouteName,
        path: "/signup",
        builder: (context, state) => SignUpPage(),
      ),
    ],
    errorBuilder: (context, state) => SignInPage(),
  );
}
