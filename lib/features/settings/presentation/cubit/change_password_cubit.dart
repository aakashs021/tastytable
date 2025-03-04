import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastytable/features/settings/data/model/change_password_error_message_model.dart';
import 'package:tastytable/features/settings/domain/usecase/check_password_and_update_usecase.dart';
import 'package:tastytable/service_locator.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(): super(ChangePasswordStateInital());

  onConfirm({required String currentPassword,required String newPassword})async{
    emit(ChangePasswordStateLoading());

    Either<ChangePasswordErrorMessageModel, bool> result = await ServiceLocator.sl<
                                  CheckPasswordAndUpdateUsecase>().call(params1: currentPassword, params2: newPassword);

    result.fold((l) => emit(ChangePasswordStateFailure(model: l)), (r) => emit(ChangePasswordStateSuccess()),);
  }
}
class ChangePasswordState {}

class ChangePasswordStateInital extends ChangePasswordState{}

class ChangePasswordStateLoading extends ChangePasswordState{}

class ChangePasswordStateFailure extends ChangePasswordState{
  ChangePasswordErrorMessageModel model;
  ChangePasswordStateFailure({required this.model});
}
class ChangePasswordStateSuccess extends ChangePasswordState {}