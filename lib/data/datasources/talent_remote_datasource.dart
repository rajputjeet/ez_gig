import '../../core/constants/api_constants.dart';
import '../../core/network/http_client.dart';
import '../models/user_list_model.dart';

abstract class ITalentRemoteDatasource {
  Future<List<UserListModel>> getUsers({required int limit, required int skip});
}

class TalentRemoteDatasource implements ITalentRemoteDatasource {
  final AppHttpClient _client;
  const TalentRemoteDatasource(this._client);

  @override
  Future<List<UserListModel>> getUsers({
    required int limit,
    required int skip,
  }) async {
    final json = await _client.get(
      ApiConstants.dummyBase,
      ApiConstants.usersEndpoint,
      queryParams: {'limit': '$limit', 'skip': '$skip'},
    );
    final list = json['users'] as List<dynamic>? ?? [];
    return list
        .map((e) => UserListModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
