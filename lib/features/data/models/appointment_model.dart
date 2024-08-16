import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookadoc_server/core/enums/appointment_status_enum.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    required super.id,
    required super.patientName,
    required super.patientId,
    required super.doctorName,
    required super.doctorId,
    required super.bookDate,
    required super.dateTime,
    required super.status,
    required super.note,
    required super.desease,
    required super.feeAmount,
  });

  factory AppointmentModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return AppointmentModel(
      id: json.data()["id"],
      patientName: json.data()["patientName"],
      patientId: json.data()["patientId"],
      doctorName: json.data()["doctorName"],
      bookDate: (json.data()["bookDate"] as Timestamp).toDate(),
      doctorId: json.data()["doctorId"],
      dateTime: (json.data()["dateTime"] as Timestamp).toDate(),
      status: AppointmentStatus.values
          .where((value) => value.name == json.data()["status"])
          .first,
      note: json.data()["note"],
      desease: json.data()["desease"],
      feeAmount: json.data()["feeAmount"],
    );
  }

  Map<String, dynamic> toJson(AppointmentModel appointmentModel) {
    return {
      "id": appointmentModel.id,
      "patientName": appointmentModel.patientName,
      "patientId": appointmentModel.patientId,
      "doctorName": appointmentModel.doctorName,
      "doctorId": appointmentModel.doctorId,
      "bookDate": appointmentModel.bookDate,
      "dateTime": appointmentModel.dateTime,
      "status": appointmentModel.status.name,
      "note": appointmentModel.note,
      "desease": appointmentModel.desease,
      "feeAmount": appointmentModel.feeAmount,
    };
  }
}
