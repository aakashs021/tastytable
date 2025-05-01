import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/settings/domain/usecase/accoun_delete_usecase.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20account%20bloc/delete_account_event.dart';
import 'package:tastytable/features/settings/presentation/bloc/delete%20account%20bloc/delete_account_state.dart';
import 'package:tastytable/service_locator.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc() : super(DeleteAccountInitialState()) {
    on<OnDeleteAccountEvent>(_onDelete);
  }

  _onDelete(
      OnDeleteAccountEvent event, Emitter<DeleteAccountState> emit) async {
    emit(DeleteAccountLoadingState());
    Either<String, bool> result = await ServiceLocator.sl<AccounDeleteUsecase>()
        .call(params1: event.password, params2: event.reason);

    result.fold(
      (l) => emit(DeleteAccountFailureState(errorText: l)),
      (r) => emit(DeleteAccountSuccessState()),
    );
  }
}
