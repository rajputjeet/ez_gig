import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../core/utils/result.dart';

class SignInUseCase {
  final AuthRepository _repository;
  const SignInUseCase(this._repository);

  Future<Result<UserEntity>> call({
    required String username,
    required String password,
  }) =>
      _repository.signIn(username: username, password: password);
}
