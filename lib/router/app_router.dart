import 'package:go_router/go_router.dart';
import 'package:tastytable/router/app_router_constants.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tastytable/features/profile/presentation/pages/settings.dart';
import 'package:tastytable/features/recipes/presentation/pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/signin",
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
