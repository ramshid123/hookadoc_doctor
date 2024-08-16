import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookadoc_server/core/constants/firestore_collections.dart';
import 'package:hookadoc_server/core/enums/appointment_status_enum.dart';
import 'package:hookadoc_server/core/exception/exception.dart';
import 'package:hookadoc_server/features/data/models/appointment_model.dart';

abstract interface class RemoteDatasource {
  Future<List<AppointmentModel>> getAppointments(
      {required String doctorId, required int count});

  Future<int> getTodayCountData({required String doctorId});
  Future<int> getPendingCountData({required String doctorId});
  Future<int> getDoneCountData({required String doctorId});
  Future<int> getMissedCountData({required String doctorId});

  Future<AppointmentModel?> getAppointmentFromId(
      {required String doctorId, required String appointmentId});
}

class RemoteDataSourceImpl implements RemoteDatasource {
  final FirebaseFirestore firestoreDB;

  RemoteDataSourceImpl(this.firestoreDB);

  @override
  Future<List<AppointmentModel>> getAppointments(
      {required String doctorId, required int count}) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.appointments)
          .where('doctorId', isEqualTo: doctorId)
          .limit(count)
          .where('dateTime', isGreaterThan: Timestamp.fromDate(DateTime.now()))
          .get();
      List<AppointmentModel> appointments = [];

      for (var doc in response.docs) {
        appointments.add(AppointmentModel.fromJson(doc));
      }

      return appointments;
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<int> getDoneCountData({required String doctorId}) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.appointments)
          .where('doctorId', isEqualTo: doctorId)
          .where('dateTime', isLessThan: Timestamp.fromDate(DateTime.now()))
          .where('dateTime',
              isGreaterThan: Timestamp.fromDate(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day)))
          .where('status', isEqualTo: AppointmentStatus.completed.name)
          .count()
          .get();
      return response.count ?? 0;
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<int> getMissedCountData({required String doctorId}) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.appointments)
          .where('doctorId', isEqualTo: doctorId)
          .where('dateTime', isLessThan: Timestamp.fromDate(DateTime.now()))
          .where('dateTime',
              isGreaterThan: Timestamp.fromDate(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day)))
          .where('status', isEqualTo: AppointmentStatus.scheduled.name)
          .count()
          .get();
      return response.count ?? 0;
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<int> getPendingCountData({required String doctorId}) async {
    try {
      final response = await firestoreDB
          .collection(FirestoreCollections.appointments)
          .where('doctorId', isEqualTo: doctorId)
          .where('dateTime', isGreaterThan: Timestamp.fromDate(DateTime.now()))
          .where('dateTime',
              isLessThan: Timestamp.fromDate(DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day)
                  .add(const Duration(days: 1))))
          .where('status', isEqualTo: AppointmentStatus.scheduled.name)
          .count()
          .get();
      return response.count ?? 0;
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<int> getTodayCountData({required String doctorId}) async {
    try {
      // Get the current date
      final now = DateTime.now();

      // Create timestamps for the start and end of today
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      // Convert them to Firestore Timestamps
      final Timestamp startTimestamp = Timestamp.fromDate(startOfDay);
      final Timestamp endTimestamp = Timestamp.fromDate(endOfDay);

      final response = await firestoreDB
          .collection(FirestoreCollections.appointments)
          .where('doctorId', isEqualTo: doctorId)
          .where('dateTime', isGreaterThanOrEqualTo: startTimestamp)
          .where('dateTime', isLessThan: endTimestamp)
          .count()
          .get();
      return response.count ?? 0;
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<AppointmentModel?> getAppointmentFromId(
      {required String doctorId, required String appointmentId}) async {
    try {
      final appointment = await firestoreDB
          .collection(FirestoreCollections.appointments)
          .where('doctorId', isEqualTo: doctorId)
          .where('id', isEqualTo: appointmentId)
          .limit(1)
          .get();

      return appointment.docs.isEmpty
          ? null
          : AppointmentModel.fromJson(appointment.docs.first);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }
}
