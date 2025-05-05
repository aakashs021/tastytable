import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:tastytable/features/detail/presentation/pages/detail_page.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/presentation/pages/view_all_page.dart';
import 'package:tastytable/features/search/presentation/pages/search_page.dart';
import 'package:tastytable/features/settings/presentation/pages/delete_account_page.dart';
import 'package:tastytable/features/settings/presentation/pages/delete_confirm_page.dart';
import 'package:tastytable/features/settings/presentation/pages/edit_name_page.dart';
import 'package:tastytable/features/settings/presentation/pages/edit_password_page.dart';
import 'package:tastytable/features/settings/presentation/pages/password_check_page.dart';
import 'package:tastytable/features/settings/presentation/pages/privacy_and_policy_page.dart';
import 'package:tastytable/router/app_router_constants.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_in_page.dart';
import 'package:tastytable/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tastytable/features/settings/presentation/pages/settings.dart';
import 'package:tastytable/features/recipes/presentation/pages/home_page.dart';

class AppRouter {
  static String initalPage() {
    if (FirebaseAuth.instance.currentUser == null) {
      return '/signin';
    } else {
      return '/home';
    }
  }

  static final GoRouter router = GoRouter(
    initialLocation: initalPage(),
    routes: <RouteBase>[
      GoRoute(
          name: AppRouterConstants.homeRouteName,
          path: '/home',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(path: '/searchpage',
            name: AppRouterConstants.searchPageRouteName,
            builder: (context, state) => SearchPage(),
            routes: [
              GoRoute(path: '/detail/:id',
              name: AppRouterConstants.detailSearchPageRouteName,
              builder: (context, state) => DetailPage(id: state.pathParameters['id']!),
              )
            ]
            ),
            // View all page with page slid transition
            GoRoute(
              name: AppRouterConstants.viewAllPageRouteName,
              path: '/viewAll/:title',
              pageBuilder: (context, state) {
                // Ensure recipes data is not null or empty
                final recipes = state.extra as List<RecipeHomeModel>?;
                if (recipes == null || recipes.isEmpty) {
                  // Handle empty or null recipes list
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: Scaffold(
                      body: Center(child: Text("No Recipes Found")),
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // Sliding transition from right to left
                      var slideTween = Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero,
                      );
                      final slideAnimation = slideTween.animate(animation);

                      return SlideTransition(
                          position: slideAnimation, child: child);
                    },
                  );
                }

                return CustomTransitionPage(
                  key: state.pageKey,
                  child: ViewAllPage(
                    title: state.pathParameters['title']!,
                    recipes: recipes,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Sliding transition from right to left
                    var slideTween = Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end: Offset.zero,
                    );
                    final slideAnimation = slideTween.animate(animation);

                    return SlideTransition(
                        position: slideAnimation, child: child);
                  },
                );
              },
              builder: (context, state) {
                final recipes = state.extra as List<RecipeHomeModel>?;
                return ViewAllPage(
                  title: state.pathParameters['title']!,
                  recipes: recipes ?? [],
                );
              },
              routes: [
                GoRoute(path: '/detailpage/:id',
  name: AppRouterConstants.detailViewAllPageRouteName,
  builder: (context, state) => DetailPage(id: state.pathParameters['id']!),
)
              ]
            ),
            GoRoute(
  name: AppRouterConstants.settingsRouteName,
  path: '/settings',
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: const SettingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the slide transition from the top-right corner
        var slideTween = Tween<Offset>(
          begin: Offset(1.0, -1.0), // Start from top-right corner
          end: Offset.zero,          // End at the default position
        );
        final slideAnimation = slideTween.animate(animation);

        // Optionally, add a fade transition along with the slide
        final fadeAnimation = animation.drive(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(opacity: fadeAnimation, child: child),
        );
      },
    );
  },
  builder: (context, state) =>  SettingPage(),
  routes: [
    GoRoute(path: '/deleteaccount',
      name: AppRouterConstants.deleteAccountPageRouteName,
      builder: (context, state) => DeleteAccountPage(),
      routes: [
        GoRoute(path: '/deleteaccountconfirm',
        name: AppRouterConstants.deleteAccountConfirmPageRouteName,
        builder: (context, state) => DeleteAccountConfirmPage(reason: state.extra as String?,),
        routes: [
          GoRoute(path: '/passwordcheck/:email',
          name: AppRouterConstants.checkPasswordPageRouteName,
          builder: (context, state) => PasswordCheckPage(email: state.pathParameters['email']!,
            reason: state.extra as String?
          ),
          )
        ]
        ),
        
      ]
    ),
    GoRoute(path: '/editname/:username',
    name: AppRouterConstants.editNameRouteName,
    builder: (context, state) => EditNamePage(userName: state.pathParameters['username']!),
    ),
    GoRoute(path: '/editpassword',
    name: AppRouterConstants.editPasswordRouteName,
    builder: (context, state) => EditPasswordPage(),
    ),
    GoRoute(
      name: AppRouterConstants.privacyAndPolicyRouteName,
      path: '/privacy&policy',
      builder: (context, state) => PrivacyAndPolicy(),
      ),
    
  ]
),
GoRoute(path: '/detailpage/:id',
  name: AppRouterConstants.detailHomePageRouteName,
  builder: (context, state) => DetailPage(id: state.pathParameters['id']!),
)

          ]),
      GoRoute(
        name: AppRouterConstants.signInRouteName,
        path: "/signin",
        builder: (context, state) => SignInPage(),
        routes: [
          GoRoute(path: '/forgotpassword',
          name: AppRouterConstants.forgotPasswordRouteName,
          builder: (context, state) => ForgotPasswordPage(),
          // routes: [
          //   GoRoute(path: '/openemail',
          //   name: AppRouterConstants.openEmailPageRouteName,
          //   builder: (context, state) => OpenEmailPage(),
          //   )
          // ]
          )
        ]
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
