import '../../core/constants/api_constants.dart';
import '../../core/network/http_client.dart';
import '../models/user_model.dart';

abstract class IAuthRemoteDatasource {
  Future<UserModel> login({required String username, required String password});
}

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final AppHttpClient _client;
  const AuthRemoteDatasource(this._client);

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final json = await _client.post(
      ApiConstants.dummyBase,
      ApiConstants.loginEndpoint,
      body: {'username': username, 'password': password, 'expiresInMins': 30},
    );
    return UserModel.fromJson(json);
  }
}
