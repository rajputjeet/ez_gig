import '../../core/errors/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/talent_entity.dart';
import '../../domain/repositories/talent_repository.dart';
import '../datasources/talent_remote_datasource.dart';

class TalentRepositoryImpl implements TalentRepository {
  final ITalentRemoteDatasource _remote;
  const TalentRepositoryImpl(this._remote);

  @override
  Future<Result<List<TalentEntity>>> getTalent({int limit = 10, int skip = 0}) async {
    try {
      final models = await _remote.getUsers(limit: limit, skip: skip);
      final entities = models
          .asMap()
          .entries
          .map((e) => e.value.toEntity(e.key))
          .toList();
      return Success(entities);
    } on AppException catch (e) {
      return Failure(e.message);
    } catch (_) {
      return Failure('Failed to load talent. Please try again.');
    }
  }
}
