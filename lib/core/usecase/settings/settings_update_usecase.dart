abstract class SettingsUpdateUsecase<Type,Params> {
  Future<Type> call({required Params params});
}