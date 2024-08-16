import 'package:fpdart/src/either.dart';
import 'package:hookadoc_server/core/exception/failure.dart';
import 'package:hookadoc_server/core/usecase/usecase_base.dart';
import 'package:hookadoc_server/features/domain/entities/count_data_entity.dart';
import 'package:hookadoc_server/features/domain/repository/repository.dart';

class UsecaseGetCountDatas
    implements UseCase<CountDataEntity, UsecaseGetCountDatasParams> {
  final AppointmentRepository repository;

  UsecaseGetCountDatas(this.repository);

  @override
  Future<Either<kFailure, CountDataEntity>> call(
          UsecaseGetCountDatasParams params) async =>
      await repository.getCountData(params.doctorId);
}

class UsecaseGetCountDatasParams {
  final String doctorId;

  UsecaseGetCountDatasParams({required this.doctorId});
}
