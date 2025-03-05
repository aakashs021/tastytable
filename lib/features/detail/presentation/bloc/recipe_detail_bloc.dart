import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/detail/data/model/recipe_detail_model.dart';
import 'package:tastytable/features/detail/domain/usecase/recipe_detail_usecase.dart';
import 'package:tastytable/features/detail/presentation/bloc/recipe_detail_event.dart';
import 'package:tastytable/features/detail/presentation/bloc/recipe_detail_state.dart';
import 'package:tastytable/service_locator.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent,RecipeDetailState> {
  RecipeDetailBloc():super(RecipeDetailInitialState()){
    on<RecipeDetailGetIndividualRecipeEvent>(_getIndividualDetail);
  }

    _getIndividualDetail(RecipeDetailGetIndividualRecipeEvent event,Emitter<RecipeDetailState> emit)async{
      emit(RecipeDetailLoadingState());
      try{
       final Either<String, RecipeDetailModel> result = await ServiceLocator.sl<RecipeDetailUsecase>().call(id: event.id);
      result.fold((l) => emit(RecipeDetailFailureState()), (model) => emit(RecipeDetailSuccessState(model: model)),);


      }catch (e){
        emit(RecipeDetailFailureState());
      }
    }
}