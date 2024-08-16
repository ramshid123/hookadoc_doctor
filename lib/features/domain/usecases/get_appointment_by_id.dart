import 'package:fpdart/src/either.dart';
import 'package:hookadoc_server/core/exception/failure.dart';
import 'package:hookadoc_server/core/usecase/usecase_base.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:hookadoc_server/features/domain/repository/repository.dart';

class UsecaseGetAppointmentById
    implements UseCase<AppointmentEntity?, UsecaseGetAppointmentByIdParams> {
  final AppointmentRepository repository;

  UsecaseGetAppointmentById(this.repository);

  @override
  Future<Either<kFailure, AppointmentEntity?>> call(
      UsecaseGetAppointmentByIdParams params) async {
    return await repository.getAppointmentFromId(
        doctorId: params.doctorId, appointmentId: params.appointmentId);
  }
}

class UsecaseGetAppointmentByIdParams {
  final String doctorId;
  final String appointmentId;

  UsecaseGetAppointmentByIdParams(
      {required this.doctorId, required this.appointmentId});
}
