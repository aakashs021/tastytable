import 'package:get_it/get_it.dart';
import 'package:tastytable/core/network/api_client.dart';
import 'package:tastytable/core/usecase/recipe/recipe_usecase.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service_impl.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service_impl.dart';
import 'package:tastytable/features/auth/data/repository/auth_repository_impl.dart';
import 'package:tastytable/features/auth/data/repository/firestore_repository_impl.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/features/auth/domain/usecase/get_user_usecase.dart';
import 'package:tastytable/features/auth/domain/usecase/signin_usecase.dart';
import 'package:tastytable/features/auth/domain/usecase/signup_usecase.dart';
import 'package:tastytable/features/recipes/data/data%20source/recipe_remote_data_source.dart';
import 'package:tastytable/features/recipes/data/repository/recipe_remote_repo_impl.dart';
import 'package:tastytable/features/recipes/domain/repository/recipe_remote_repo.dart';
import 'package:tastytable/features/recipes/domain/usecase/get_italian_cusine_usecase.dart';

class ServiceLocator {
  static final sl = GetIt.instance;

  static Future<void> initializeDependencies() async {
    // Auth
    sl.registerLazySingleton<AuthFirebaseService>(() => AuthFirebaseServiceImpl());
    sl.registerLazySingleton<AuthRepostory>(() => AuthRepositoryImpl());
    sl.registerLazySingleton<SignupUsecase>(() => SignupUsecase());
    sl.registerLazySingleton<FirebaseFirestoreService>(() => FirebaseFirestoreServiceImpl());
    sl.registerLazySingleton<FirestoreRepository>(() => FirestoreRepositoryImpl());
    sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());
    sl.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase());
    // Api
    sl.registerLazySingleton<ApiClient>(() => ApiClient(),);
    // Recipe
    sl.registerLazySingleton<RecipeRemoteDataSource>(() => RecipeRemoteDataSourceImpl(),);
       sl.registerLazySingleton<RecipeRemoteRepo>(() => RecipeRemoteRepoImpl(),);
         sl.registerLazySingleton<GetItalianCusineUsecase>(() => GetItalianCusineUsecase(),);

  }
}