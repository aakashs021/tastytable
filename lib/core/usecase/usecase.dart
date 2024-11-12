abstract class Usecase<Type,Params1,Params2> {
  Future<Type> call({required Params1 params1,required Params2 params2});
}