import 'package:hookadoc_server/core/enums/appointment_status_enum.dart';

class AppointmentEntity {
  final String id;
  final String patientName;
  final String patientId;
  final String doctorName;
  final String doctorId;
  final DateTime dateTime;
  final DateTime bookDate;
  final AppointmentStatus status;
  final String note;
  final String desease;
  final double feeAmount;

  AppointmentEntity({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.doctorName,
    required this.doctorId,
    required this.dateTime,
    required this.bookDate,
    required this.status,
    required this.note,
    required this.desease,
    required this.feeAmount,
  });
}
