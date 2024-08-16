import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hookadoc_server/core/exception/exception.dart';
import 'package:hookadoc_server/core/exception/failure.dart';
import 'package:hookadoc_server/features/data/datasources/remote_datasource.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:hookadoc_server/features/domain/entities/count_data_entity.dart';
import 'package:hookadoc_server/features/domain/repository/repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final RemoteDatasource remoteDatasource;

  AppointmentRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<kFailure, List<AppointmentEntity>>> getAppointments(
      {required String doctorId, required int count}) async {
    try {
      final appointments = await remoteDatasource.getAppointments(
          doctorId: doctorId, count: count);

      return right(appointments);
    } on KustomException catch (e) {
      return left(kFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<kFailure, CountDataEntity>> getCountData(
      String doctorId) async {
    try {
      final todayCount =
          await remoteDatasource.getTodayCountData(doctorId: doctorId);
      final pendingCount =
          await remoteDatasource.getPendingCountData(doctorId: doctorId);
      final doneCount =
          await remoteDatasource.getDoneCountData(doctorId: doctorId);
      final missedCount =
          await remoteDatasource.getMissedCountData(doctorId: doctorId);

      final countData = CountDataEntity(
          today: todayCount,
          pending: pendingCount,
          done: doneCount,
          missed: missedCount);

      return right(countData);
    } on KustomException catch (e) {
      return left(kFailure(e.errorMessage));
    }
  }

  @override
  Future<Either<kFailure, AppointmentEntity?>> getAppointmentFromId(
      {required String doctorId, required String appointmentId}) async {
    try {
      final response = await remoteDatasource.getAppointmentFromId(
          doctorId: doctorId, appointmentId: appointmentId);
      return right(response);
    } on KustomException catch (e) {
      return left(kFailure(e.errorMessage));
    }
  }

  // @override
  // Future<Either<kFailure, CountDataEntity>> getCountData(
  //     String doctorId) async {
  //   try {
  //     final Timestamp targetTimestamp = Timestamp.fromDate(DateTime.now());

  //     final todayCount =
  //         await remoteDatasource.getCountData(doctorId: doctorId);
  //   } on KustomException catch (e) {
  //     return left(kFailure(e.errorMessage));
  //   }
  // }
}
