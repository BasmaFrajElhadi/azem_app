// // import '../../domain/entities/user_entities.dart';
// // import '../../domain/repositories/user_repository.dart';
// // import '../datasources/firebase_datasource.dart';
// // import '../models/user_model.dart';
// //
// // class UserRepositoryImpl implements UserRepository {
// //   final FirebaseDataSource firebaseDataSource;
// //
// //   UserRepositoryImpl(this.firebaseDataSource);
// //
// //   @override
// //   Future<UserEntities?> login(String email, String password) async {
// //     UserModel? user = await firebaseDataSource.getUserByEmail(email);
// //     if (user != null && user.password == password) {
// //       return user;
// //     }
// //     return null;
// //   }
// // }
// // data/repositories/auth_repository_impl.dart
//
//
// import '../../domain/entities/user_entities.dart';
// import '../../domain/repositories/user_repository.dart';
// import '../dataSources/auth_remote_data_source.dart';
// import '../models/user_model.dart';
//
// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//
//   AuthRepositoryImpl({required this.remoteDataSource});
//
//   @override
//   Future<void> signUp(User user) {
//     return remoteDataSource.signUp(user as UserModel);
//   }
//
//   @override
//   Future<User> login(String email, String password) async {
//     return await remoteDataSource.login(email, password);
//   }
//
//   @override
//   Future<void> logout() {
//     return remoteDataSource.logout();
//   }
// }
//
// // data/repositories/nutritionist_repository_impl.dart
//
//
// class NutritionistRepositoryImpl implements NutritionistRepository {
//   final NutritionistRemoteDataSource remoteDataSource;
//
//   NutritionistRepositoryImpl({required this.remoteDataSource});
//
//   @override
//   Future<void> addNutritionist(Nutritionist nutritionist) {
//     return remoteDataSource.addNutritionist(nutritionist as NutritionistModel);
//   }
// }
//
// // data/repositories/user_repository_impl.dart
//
//
// class UserRepositoryImpl implements UserRepository {
//   final UserRemoteDataSource remoteDataSource;
//
//   UserRepositoryImpl({required this.remoteDataSource});
//
//   @override
//   Future<void> addUser(RegularUser user) {
//     return remoteDataSource.addUser(user as RegularUserModel);
//   }
// }
