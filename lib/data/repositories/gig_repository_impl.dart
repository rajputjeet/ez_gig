import '../../core/errors/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/gig_entity.dart';
import '../../domain/repositories/gig_repository.dart';
import '../datasources/gig_remote_datasource.dart';

class GigRepositoryImpl implements GigRepository {
  final IGigRemoteDatasource _remote;
  const GigRepositoryImpl(this._remote);

  @override
  Future<Result<List<GigEntity>>> getUpcomingGigs({
    int limit = 10,
    int skip = 0,
  }) =>
      _fetchGigs(limit: limit, skip: skip);

  @override
  Future<Result<List<GigEntity>>> getAllGigs({
    int limit = 20,
    int skip = 0,
  }) =>
      _fetchGigs(limit: limit, skip: skip);

  Future<Result<List<GigEntity>>> _fetchGigs({
    required int limit,
    required int skip,
  }) async {
    try {
      final models = await _remote.getProducts(limit: limit, skip: skip);
      final entities = models
          .asMap()
          .entries
          .map((e) => e.value.toEntity(e.key))
          .toList();
      return Success(entities);
    } on AppException catch (e) {
      return Failure(e.message);
    } catch (_) {
      return Failure('Failed to load gigs. Please try again.');
    }
  }
}
