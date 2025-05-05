import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/features/detail/presentation/bloc/recipe_detail_bloc.dart';
import 'package:tastytable/features/detail/presentation/bloc/recipe_detail_event.dart';
import 'package:tastytable/features/detail/presentation/bloc/recipe_detail_state.dart';
import 'package:tastytable/features/detail/presentation/widgets/detail_content2.dart';
import 'package:tastytable/features/detail/presentation/widgets/detail_page_failure.dart';
import 'package:tastytable/features/detail/presentation/widgets/shimmer.dart';

class DetailPage extends StatefulWidget {
  final String id;

  DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
context.read<RecipeDetailBloc>().add(RecipeDetailGetIndividualRecipeEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<RecipeDetailBloc,RecipeDetailState>(
            builder: (context, state) {
                if(state is RecipeDetailLoadingState){
                  return DetailPageShimmer();
                }
                if(state is RecipeDetailFailureState){
                return  DetailPageFailure();
                }
                // RecipeDetailModel model;
                if(state is RecipeDetailSuccessState){
                 RecipeDetailModel model = state.model;
                return DetailContent2(recipe: model,);
                }
                return SizedBox();
            },
          ),);
  }
}


          