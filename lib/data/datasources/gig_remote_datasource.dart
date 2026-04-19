import '../../core/constants/api_constants.dart';
import '../../core/network/http_client.dart';
import '../models/product_model.dart';

abstract class IGigRemoteDatasource {
  Future<List<ProductModel>> getProducts({required int limit, required int skip});
}

class GigRemoteDatasource implements IGigRemoteDatasource {
  final AppHttpClient _client;
  const GigRemoteDatasource(this._client);

  @override
  Future<List<ProductModel>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final json = await _client.get(
      ApiConstants.dummyBase,
      ApiConstants.productsEndpoint,
      queryParams: {'limit': '$limit', 'skip': '$skip'},
    );
    final list = json['products'] as List<dynamic>? ?? [];
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
