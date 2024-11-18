abstract class Usecase<Type,Params1> {
  Future<Type> call({required Params1 params1});
}