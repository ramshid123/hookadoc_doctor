import 'package:fpdart/fpdart.dart';
import 'package:hookadoc_server/core/exception/failure.dart';
import 'package:hookadoc_server/core/usecase/usecase_base.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:hookadoc_server/features/domain/repository/repository.dart';

class UsecaseGetAllAppointments
    implements
        UseCase<List<AppointmentEntity>, UsecaseGetAllAppointmentsParams> {
  final AppointmentRepository repository;

  UsecaseGetAllAppointments(this.repository);

  @override
  Future<Either<kFailure, List<AppointmentEntity>>> call(
      UsecaseGetAllAppointmentsParams params) async {
    return await repository.getAppointments(
        doctorId: params.doctorId, count: params.count);
  }
}

class UsecaseGetAllAppointmentsParams {
  final String doctorId;
  final int count;

  UsecaseGetAllAppointmentsParams(
      {required this.doctorId, required this.count});
}
