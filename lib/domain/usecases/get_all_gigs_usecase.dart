import '../entities/gig_entity.dart';
import '../repositories/gig_repository.dart';
import '../../core/utils/result.dart';

class GetAllGigsUseCase {
  final GigRepository _repository;
  const GetAllGigsUseCase(this._repository);

  Future<Result<List<GigEntity>>> call({int limit = 20, int skip = 0}) =>
      _repository.getAllGigs(limit: limit, skip: skip);
}
