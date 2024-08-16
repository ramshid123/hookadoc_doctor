import 'package:fpdart/fpdart.dart';
import 'package:hookadoc_server/core/exception/failure.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:hookadoc_server/features/domain/entities/count_data_entity.dart';

abstract interface class AppointmentRepository {
  Future<Either<kFailure, List<AppointmentEntity>>> getAppointments(
      {required String doctorId, required int count});

  Future<Either<kFailure, CountDataEntity>> getCountData(String doctorId);

  Future<Either<kFailure, AppointmentEntity?>> getAppointmentFromId(
      {required String doctorId, required String appointmentId});
}
