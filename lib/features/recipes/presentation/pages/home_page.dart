import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/features/auth/domain/usecase/signout_usecase.dart';
import 'package:tastytable/features/auth/presentation/bloc/auth_state.dart';
import 'package:tastytable/features/auth/presentation/widgets/snack_bar.dart';
import 'package:tastytable/router/app_router_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Text("Explore"),
              Text('What would you like to eat?'),
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.red,
              ),
              Text('Kerala Cusine'),
              Container(
                height: 250,
                child: ListView.builder(
                  padding: EdgeInsets.all(5),
                  // shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                    );
                  },
                ),
              ),
              Text('Kerala Cusine'),
              Container(
                height: 250,
                child: ListView.builder(
                  padding: EdgeInsets.all(5),
                  // shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      width: 200,
                      height: 200,
                      color: Colors.blue,
                    );
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Either<String, String> result = SignoutUsecase().call();
                    result.fold(
                      (l) =>
                          authSnackBar(context: context, state: AuthError(l)),
                      (r) =>
                          context.goNamed(AppRouterConstants.signInRouteName),
                    );
                  },
                  child: const Text('signout')),
            ],
          ),
        ),
      ),
    );
  }
}
