import '../entities/gig_entity.dart';
import '../repositories/gig_repository.dart';
import '../../core/utils/result.dart';

class GetUpcomingGigsUseCase {
  final GigRepository _repository;
  const GetUpcomingGigsUseCase(this._repository);

  Future<Result<List<GigEntity>>> call({int limit = 10}) =>
      _repository.getUpcomingGigs(limit: limit);
}
