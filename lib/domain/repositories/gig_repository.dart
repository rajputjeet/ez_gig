import '../entities/gig_entity.dart';
import '../../core/utils/result.dart';

abstract class GigRepository {
  Future<Result<List<GigEntity>>> getUpcomingGigs({int limit = 10, int skip = 0});
  Future<Result<List<GigEntity>>> getAllGigs({int limit = 20, int skip = 0});
}
