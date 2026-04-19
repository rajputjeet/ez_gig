import '../entities/talent_entity.dart';
import '../repositories/talent_repository.dart';
import '../../core/utils/result.dart';

class GetTalentUseCase {
  final TalentRepository _repository;
  const GetTalentUseCase(this._repository);

  Future<Result<List<TalentEntity>>> call({int limit = 10}) =>
      _repository.getTalent(limit: limit);
}
