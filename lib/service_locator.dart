import 'package:get_it/get_it.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service_impl.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service_impl.dart';
import 'package:tastytable/features/auth/data/repository/auth_repository_impl.dart';
import 'package:tastytable/features/auth/data/repository/firestore_repository_impl.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/features/auth/domain/usecase/signup_usecase.dart';

class ServiceLocator {
  static final sl = GetIt.instance;

  static Future intializeDependencies() async {
    sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
    sl.registerSingleton<AuthRepostory>(AuthRepositoryImpl());
    sl.registerSingleton<SignupUsecase>(SignupUsecase());
    sl.registerSingleton<FirebaseFirestoreService>(
        FirebaseFirestoreServiceImpl());
    sl.registerSingleton<FirestoreRepository>(FirestoreRepositoryImpl());
    sl.registerSingleton<SignupUsecase>(SignupUsecase());
  }
}
