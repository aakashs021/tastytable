import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/search/presentation/bloc/search_bloc.dart';
import 'package:tastytable/features/search/presentation/bloc/search_event.dart';
import 'package:tastytable/features/search/presentation/bloc/search_state.dart';
import 'package:tastytable/features/search/presentation/widgets/search_page_failure.dart';
import 'package:tastytable/features/search/presentation/widgets/search_page_loading.dart';
import 'package:tastytable/features/search/presentation/widgets/search_success_builder.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        surfaceTintColor: AppColors.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Padding(
          padding:
              EdgeInsets.zero, // Remove the padding between leading and title
          child: TextField(
            onChanged: (value) {
              if (value.isEmpty) {
                context.read<SearchBloc>().add(OnTextEmptyEvent());
                return;
              } else {
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(const Duration(milliseconds: 1500), () {
                  context
                      .read<SearchBloc>()
                      .add(OnSearchEvent(searchText: value));
                });
              }
            },
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search recipes', // Hint text for the TextField
              border: InputBorder.none, // Remove the border completely
              focusedBorder: InputBorder.none, // Ensure no border when focused
              enabledBorder:
                  InputBorder.none, // Ensure no border when not focused
            ),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Divider(
                color: Colors.grey,
              ),
            )),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoaindgState) {
            return SearchPageLoading(context: context);
          }
          if (state is SearchFailureState) {
            return SearchPageFailure(searchText: searchController.text);
          }
          if (state is SearchSuccessState) {
            return SearchSuccessBuilder(
              recipes: state.model,
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  recommendIngredients(),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   height: 200,
                  //   color: Colors.blue,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget recommendIngredients() {
  return Container(
    height: 200,
    color: Colors.green,
    width: double.infinity,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              // bottom: 0,
              child: Container(
                margin: EdgeInsets.all(5),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 150,
                width: 100,

                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  color: Colors.red,
                ),
                // child: CircleAvatar(
                //   backgroundColor: Colors.red,
                //   radius: 60,
                // ),
              ),
            ),
            Positioned(bottom: 40, child: Text('Ingredients'))
          ],
        );
      },
      itemCount: 5,
    ),
  );
}
