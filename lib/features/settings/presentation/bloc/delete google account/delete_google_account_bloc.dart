import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/settings/domain/usecase/delete_google_account_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/get_login_method_usecase.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20google%20account/delete_google_account_event.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20google%20account/delete_google_account_state.dart';
import 'package:tastytable/service_locator.dart';

class DeleteGoogleAccountBloc extends Bloc<DeleteGoogleAccountEvent,DeleteGoogleAccountState> {
  DeleteGoogleAccountBloc():super(DeleteGoogleAccountInitalState()){
    on<OnCheckGoogleLoginEvent>(_onCheckGoogleLogin);
    on<OnDeleteGoolgleAccountEvent>(_onDeleteGoogleAccount);
  }

  _onCheckGoogleLogin( OnCheckGoogleLoginEvent event ,  Emitter<DeleteGoogleAccountState> emit){
        Either<bool,bool> checkLogin = ServiceLocator.sl<GetLoginMethodUsecase>().call();
    checkLogin.fold((l) => emit(CheckGoogleAccountSuccessState()), (r) => CheckGoogleAccountFailureState(),);
  }

  _onDeleteGoogleAccount(OnDeleteGoolgleAccountEvent event, Emitter<DeleteGoogleAccountState> emit)async{
    emit(DeleteGoogleAccountLoadingState());
    Either<String, bool> result=  await ServiceLocator.sl<DeleteGoogleAccountUsecase>().call(reason: event.reason);

    result.fold((l) => emit(DeleteGoogleAccountFailureState()), (r) => emit(DeleteGoogleAccountSuccessState()),);
  }
}