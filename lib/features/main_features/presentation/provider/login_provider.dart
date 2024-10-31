// // presentation/providers/login_provider.dart
// import 'package:flutter/material.dart';
//
// import '../../domain/entities/user_entities.dart';
// import '../../domain/useCases/login_use_case.dart';
//
// class LoginProvider with ChangeNotifier {
//   final LoginUseCase loginUseCase;
//   UserEntities? _user;
//
//   LoginProvider(this.loginUseCase);
//
//   UserEntities? get user => _user;
//
//   Future<void> login(String email, String password) async {
//     _user = await loginUseCase.execute(email, password);
//     notifyListeners();
//   }
// }
