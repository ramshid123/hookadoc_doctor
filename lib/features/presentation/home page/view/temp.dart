import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hookadoc_server/core/constants/firestore_collections.dart';
import 'package:hookadoc_server/core/enums/appointment_status_enum.dart';
import 'package:hookadoc_server/features/data/models/appointment_model.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';

class Temp {
  final DateTime now = DateTime.now();
  final Random random = Random();

  Future addDummyAppointments() async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection(FirestoreCollections.appointments);

    List<String> names = [
      'Alice Johnson',
      'Bob Smith',
      'Charlie Brown',
      'David Williams',
      'Emma Davis',
      'Fiona Garcia',
      'George Wilson',
      'Hannah Martinez',
      'Ian Anderson',
      'Jane Taylor'
    ];

    List<String> diseases = [
      'Hypertension',
      'Diabetes',
      'Asthma',
      'Influenza',
      'Arthritis',
      'Migraine',
      'Bronchitis',
      'Pneumonia',
      'Allergies',
      'Gastroenteritis'
    ];

    List<Map<String, dynamic>> appointments = List.generate(10, (index) {
      return {
        'dateTime': _generateRandomDateTime(),
        'desease': diseases[index],
        'doctorName': 'Dr. Smith',
        'feeAmount': 300 + index * 10,
        'id': 'appointment_id_${index + 1}',
        'note': 'Note for appointment ${index + 1}',
        'patientId': 'patient_id_${index + 1}',
        'patientName': names[index],
      };
    });

    for (var appnment in appointments) {
      final model = AppointmentModel(
        id: appnment['id'],
        patientName: appnment['patientName'],
        patientId: appnment['patientId'],
        doctorName: appnment['doctorName'],
        doctorId: 'test_doctor_id',
        dateTime: appnment['dateTime'],
        bookDate:
            DateTime.now().subtract(Duration(days: Random().nextInt(20) + 1)),
        status: AppointmentStatus.scheduled,
        note: appnment['note'],
        desease: appnment['desease'],
        feeAmount: double.parse(appnment['feeAmount'].toString()),
      );
      collection.add(
        model.toJson(model),
      );
    }
  }

  DateTime _generateRandomDateTime() {
    int randomHour = now.hour + random.nextInt(23 - now.hour);
    int randomMinute = random.nextInt(60);
    int randomSecond = random.nextInt(60);
    DateTime randomDateTime = DateTime(
        now.year, now.month, now.day, randomHour, randomMinute, randomSecond);
    return randomDateTime;
  }
}
