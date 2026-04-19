import '../../core/errors/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IAuthRemoteDatasource _remote;
  final AuthLocalDatasource _local;

  const AuthRepositoryImpl(this._remote, this._local);

  @override
  Future<Result<UserEntity>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final model = await _remote.login(username: username, password: password);
      await _local.cacheUser(model);
      return Success(model.toEntity());
    } on AppException catch (e) {
      return Failure(e.message);
    } catch (e) {
      return Failure('An unexpected error occurred. Please try again.');
    }
  }

  @override
  Future<void> signOut() async => _local.clearUser();

  @override
  UserEntity? getCachedUser() {
    return null;
  }
}
