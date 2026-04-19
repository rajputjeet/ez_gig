import 'package:get/get.dart';
import '../../core/network/http_client.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/gig_remote_datasource.dart';
import '../../data/datasources/talent_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/gig_repository_impl.dart';
import '../../data/repositories/talent_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/gig_repository.dart';
import '../../domain/repositories/talent_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppHttpClient>(AppHttpClient(), permanent: true);

    Get.put<IAuthRemoteDatasource>(
        AuthRemoteDatasource(Get.find()), permanent: true);
    Get.put<AuthLocalDatasource>(AuthLocalDatasource(), permanent: true);
    Get.put<IGigRemoteDatasource>(
        GigRemoteDatasource(Get.find()), permanent: true);
    Get.put<ITalentRemoteDatasource>(
        TalentRemoteDatasource(Get.find()), permanent: true);

    Get.put<AuthRepository>(
        AuthRepositoryImpl(Get.find(), Get.find()), permanent: true);
    Get.put<GigRepository>(
        GigRepositoryImpl(Get.find()), permanent: true);
    Get.put<TalentRepository>(
        TalentRepositoryImpl(Get.find()), permanent: true);
  }
}
