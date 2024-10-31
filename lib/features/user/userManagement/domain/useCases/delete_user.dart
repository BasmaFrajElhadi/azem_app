import 'package:dartz/dartz.dart';
import '../../../../../core/constants/strings/failure.dart';
import '../repositories/user_repository.dart';

class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, Unit>> call(int id) {
    return repository.deleteUser(id);
  }
}
