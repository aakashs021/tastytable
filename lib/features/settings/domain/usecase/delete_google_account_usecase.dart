import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/settings/usecase_settings_google.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/service_locator.dart';

class DeleteGoogleAccountUsecase
    implements UsecaseSettingsGoogle<Either<String, bool>> {
  @override
  Future<Either<String, bool>> call({required String? reason}) async {
    Either<String, bool> result = await ServiceLocator.sl<SettingsRepository>()
        .deleteGoogleAccount(reason: reason);
    return result;
  }
}
