import 'package:get_it/get_it.dart';
import 'package:tastytable/core/network/api_client.dart';
import 'package:tastytable/core/network/api_client_impl.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service_impl.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service_impl.dart';
import 'package:tastytable/features/auth/data/repository/auth_repository_impl.dart';
import 'package:tastytable/features/auth/data/repository/firestore_repository_impl.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/features/auth/domain/usecase/signin_usecase.dart';
import 'package:tastytable/features/auth/domain/usecase/signup_usecase.dart';
import 'package:tastytable/features/detail/data/data%20source/recipe_detail_remote_datasource.dart';
import 'package:tastytable/features/detail/data/repository/recipe_detail_repository_impl.dart';
import 'package:tastytable/features/detail/domain/repository/recipe_detail_repository.dart';
import 'package:tastytable/features/detail/domain/usecase/recipe_detail_usecase.dart';
import 'package:tastytable/features/recipes/data/data%20source/recipe_remote_data_source.dart';
import 'package:tastytable/features/recipes/data/repository/recipe_remote_repo_impl.dart';
import 'package:tastytable/features/recipes/domain/repository/recipe_remote_repo.dart';
import 'package:tastytable/features/recipes/domain/usecase/get_italian_cusine_usecase.dart';
import 'package:tastytable/features/settings/data/data%20sounce/settings_firebase_services.dart';
import 'package:tastytable/features/settings/data/repository/settings_repo_impl.dart';
import 'package:tastytable/features/settings/domain/repository/settings_repo.dart';
import 'package:tastytable/features/settings/domain/usecase/accoun_delete_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/check_password_and_update_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/delete_google_account_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/get_login_method_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/get_user_name_usecase.dart';
import 'package:tastytable/features/settings/domain/usecase/update_user_name_usecase.dart';

class ServiceLocator {
  static final sl = GetIt.instance;

  static Future<void> initializeDependencies() async {
    // Auth
    sl.registerLazySingleton<AuthFirebaseService>(
        () => AuthFirebaseServiceImpl());
    sl.registerLazySingleton<AuthRepostory>(() => AuthRepositoryImpl());
    sl.registerLazySingleton<SignupUsecase>(() => SignupUsecase());
    sl.registerLazySingleton<FirebaseFirestoreService>(
        () => FirebaseFirestoreServiceImpl());
    sl.registerLazySingleton<FirestoreRepository>(
        () => FirestoreRepositoryImpl());
    sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());

    // Api
    sl.registerLazySingleton<ApiClient>(
      () => ApiClientImpl(),
    );

    // Recipe
    sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(),
    );
    sl.registerLazySingleton<RecipeRemoteRepo>(
      () => RecipeRemoteRepoImpl(),
    );
    sl.registerLazySingleton<GetCusineUsecase>(
      () => GetCusineUsecase(),
    );

    // Settings
    sl.registerLazySingleton<SettingsFirebaseServices>(() => SettingsFirebaseServicesImpl(),);
    sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(),);
    sl.registerLazySingleton<GetUserNameUsecase>(() => GetUserNameUsecase(),);
    sl.registerLazySingleton<UpdateUserNameUsecase>(() => UpdateUserNameUsecase(),);
    sl.registerLazySingleton<GetLoginMethodUsecase>(() => GetLoginMethodUsecase(),);
    sl.registerLazySingleton<CheckPasswordAndUpdateUsecase>(() => CheckPasswordAndUpdateUsecase(),);
    sl.registerLazySingleton<AccounDeleteUsecase>(() => AccounDeleteUsecase(),);
    sl.registerLazySingleton<DeleteGoogleAccountUsecase>(() => DeleteGoogleAccountUsecase(),);

    // Detail
    sl.registerLazySingleton<RecipeDetailRemoteDatasource>(() => RecipeDetailRemoteDatasourceImpl(),);
    sl.registerLazySingleton<RecipeDetailRepository>(() => RecipeDetailRepositoryImpl(),);
    sl.registerLazySingleton<RecipeDetailUsecase>(() => RecipeDetailUsecase(),);
  }
}
