import '../entities/user_entity.dart';
import '../../core/utils/result.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signIn({
    required String username,
    required String password,
  });
  Future<void> signOut();
  UserEntity? getCachedUser();
}
