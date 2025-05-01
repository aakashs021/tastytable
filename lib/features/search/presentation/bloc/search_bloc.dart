import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/recipes/data/model/recipe_home_model.dart';
import 'package:tastytable/features/search/domain/usecase/search_usecase.dart';
import 'package:tastytable/features/search/presentation/bloc/search_event.dart';
import 'package:tastytable/features/search/presentation/bloc/search_state.dart';
import 'package:tastytable/service_locator.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchIntitalState()) {
    on<OnSearchEvent>(_onSearch);
    on<OnTextEmptyEvent>(_onTextEmpty);
  }

  Future<void> _onSearch(OnSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoaindgState());
    print('start----');
    Either<String, List<RecipeHomeModel>> result =
        await ServiceLocator.sl<SearchUsecase>()
            .call(searchText: event.searchText);
    // print('first req----------');

    List<RecipeHomeModel> validRecipes = [];
    result.fold(
      (error) {
        // print('failure req----');
        emit(SearchFailureState());
      },
      (recipes)  {
    emit(SearchSuccessState(model: recipes));
      },
    );
    print(validRecipes);
  }

  _onTextEmpty(OnTextEmptyEvent event, Emitter<SearchState> emit){
    emit(SearchIntitalState());
  }

 
}
