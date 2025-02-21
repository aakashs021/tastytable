import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/recipes/presentation/cubit/view_all_page/view_all_page_text_state.dart';

class ViewAllPageTextCubitIndian extends Cubit<ViewAllPageTextState> {
  ViewAllPageTextCubitIndian():super(ViewAllPageTextStateFailure());

  dataExists({required List<RecipeHomeModel> recipes}){
    emit(ViewAllPageTextStateSuccess(recipes: recipes));
  }
  dataNotExist(){
    emit(ViewAllPageTextStateFailure());
  }
}