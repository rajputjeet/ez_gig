import '../entities/talent_entity.dart';
import '../../core/utils/result.dart';

abstract class TalentRepository {
  Future<Result<List<TalentEntity>>> getTalent({int limit = 10, int skip = 0});
}
