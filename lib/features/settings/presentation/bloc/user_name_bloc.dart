import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tastytable/features/settings/domain/usecase/get_user_name_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/update_user_name_usecase.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_event.dart';
import 'package:tastytable/features/settings/presentation/bloc/user_name_state.dart';
import 'package:tastytable/service_locator.dart';

class UserNameBloc extends Bloc<UserNameEvent, UserNameState> {
  UserNameBloc() : super(UserNameFailure()) {
    on<ShowNameEvent>(_showUserName);
    on<NameUpdateEvent>(_updateUserName);
  }
  static GetIt serviceLocator = ServiceLocator.sl;
  _showUserName(ShowNameEvent event, Emitter<UserNameState> emit) async {
    emit(UserNameFailure());
    try {
      Either<String, String> result =
          await serviceLocator<GetUserNameUsecase>().call();
      result.fold(
        (l) => emit(UserNameFailure()),
        (r) => emit(UserNameSuccess(user_name: r)),
      );
    } catch (e) {
      emit(UserNameFailure());
    }
  }

  _updateUserName(NameUpdateEvent event, Emitter<UserNameState> emit) async {
    emit(UserNameFailure());
    try {
      Either<String, String> result =
          await serviceLocator<UpdateUserNameUsecase>()
              .call(params: event.newUserName);
      result.fold(
        (l) => emit(UserNameFailure()),
        (r) => emit(UserNameSuccess(user_name: r)),
      );
      // print(result);
    } catch (e) {
      emit(UserNameFailure());
    }
  }
}
