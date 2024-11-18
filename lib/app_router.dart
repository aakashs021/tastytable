import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_up_page.dart';

class AppRouter {
  static final  GoRouter router =GoRouter(
    initialLocation: '/signin',
    
    routes: [
      GoRoute(path: '/signin',builder: (context, state) =>  SignInPage(),),
      GoRoute(path: '/signup',builder: (context, state) =>  SignUpPage(),),
  ],
    errorBuilder: (context, state) =>  SignInPage(),
  );
}