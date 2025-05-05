import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tastytable/core/configs/assets/app_vectors.dart';
import 'package:tastytable/core/configs/theme/app_colors.dart';
import 'package:tastytable/features/search/presentation/bloc/search_bloc.dart';
import 'package:tastytable/features/search/presentation/bloc/search_event.dart';
import 'package:tastytable/features/search/presentation/bloc/search_state.dart';
import 'package:tastytable/features/search/presentation/widgets/search_ingredients_image_loader.dart';
import 'package:tastytable/features/search/presentation/widgets/search_page_failure.dart';
import 'package:tastytable/features/search/presentation/widgets/search_page_loading.dart';
import 'package:tastytable/features/search/presentation/widgets/search_success_builder.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
 final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.searchPageBGColor,
      appBar: AppBar(
        backgroundColor: AppColors.searchPageBGColor,
        surfaceTintColor: AppColors.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.read<SearchBloc>().add(OnTextEmptyEvent());

            GoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Padding(
          padding: EdgeInsets.zero,
          child: TextField(
            onChanged: (value) {
              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }
              if (value.isEmpty) {
                context.read<SearchBloc>().add(OnTextEmptyEvent());
                return;
              } else {
                _debounce = Timer(const Duration(milliseconds: 1500), () {
                  context
                      .read<SearchBloc>()
                      .add(OnSearchEvent(searchText: value));
                });
              }
            },
            controller: searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              hintText: 'Search recipes',
              suffixIcon: InkWell(
                  onTap: () {
                    searchController.text = "";
                    context.read<SearchBloc>().add(OnTextEmptyEvent());
                  },
                  child: Icon(Icons.close_sharp)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: Divider(
              color: Colors.grey,
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
                  recommendIngredients(
                    title: "Powered by Plants",
                    ingName: AppVectors.VegetablesName,
                    ingImg: AppVectors.VegetablesImg,
                    controller: searchController,
                    onIngredientTap: (selected) {
                      _debounce?.cancel();
                      context
                          .read<SearchBloc>()
                          .add(OnSearchEvent(searchText: selected));
                    },
                  ),
                  recommendIngredients(
                    title: "Non-Vegetarian Specials",
                    ingName: AppVectors.MeatName,
                    ingImg: AppVectors.MeatImg,
                    controller: searchController,
                    onIngredientTap: (selected) {
                      _debounce?.cancel();
                      context
                          .read<SearchBloc>()
                          .add(OnSearchEvent(searchText: selected));
                    },
                  ),
                  recommendIngredients(
                    title: 'Sweet & Refreshing',
                    ingName: AppVectors.fruitsName,
                    ingImg: AppVectors.fruitsImg,
                    controller: searchController,
                    onIngredientTap: (selected) {
                      _debounce?.cancel();
                      context
                          .read<SearchBloc>()
                          .add(OnSearchEvent(searchText: selected));
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget recommendIngredients({
  required String title,
  required List<String> ingName,
  required List<String> ingImg,
  required TextEditingController controller,
  required void Function(String) onIngredientTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.searchPageTitleTextColor,
              // Subtle but clear
            ),
            title),
      ),
      Container(
        // margin: EdgeInsets.only(top: 15),
        height: 180,
        // color: Colors.green,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                final selected = ingName[index];
                controller.text = selected;
                onIngredientTap(selected);
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    // bottom: 0,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      height: 130,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: SearchImageLoaderShimmer(
                      assetImage: ingImg[index],
                    ),
                  ),
                  Positioned(
                      bottom: 30,
                      child: Container(
                        width: 130,
                        child: Center(
                          child: Text(
                              style: TextStyle(
                                  color:
                                      AppColors.searchPageIngridientsTextColor,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                              ingName[index]),
                        ),
                      ))
                ],
              ),
            );
          },
          itemCount: ingImg.length,
        ),
      ),
    ],
  );
}
