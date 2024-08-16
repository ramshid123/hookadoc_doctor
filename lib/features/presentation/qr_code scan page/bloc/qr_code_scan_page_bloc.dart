import 'package:bloc/bloc.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:hookadoc_server/features/domain/usecases/get_appointment_by_id.dart';
import 'package:meta/meta.dart';

part 'qr_code_scan_page_event.dart';
part 'qr_code_scan_page_state.dart';

class QrCodeScanPageBloc
    extends Bloc<QrCodeScanPageEvent, QrCodeScanPageState> {
  final UsecaseGetAppointmentById _usecaseGetAppointmentById;

  QrCodeScanPageBloc({
    required UsecaseGetAppointmentById usecaseGetAppointmentById,
  })  : _usecaseGetAppointmentById = usecaseGetAppointmentById,
        super(QrCodeScanPageStateInitial()) {
    on<QrCodeScanPageEventEvaluateQR>((event, emit) async =>
        await _onQrCodeScanPageEventEvaluateQR(event, emit));
  }

  Future _onQrCodeScanPageEventEvaluateQR(QrCodeScanPageEventEvaluateQR event,
      Emitter<QrCodeScanPageState> emit) async {
    final response = await _usecaseGetAppointmentById(
        UsecaseGetAppointmentByIdParams(
            doctorId: event.doctorId, appointmentId: event.appointmentId));

    response.fold(
      (l) => emit(QrCodeScanPageStateFailure(l.failureMessage)),
      (r) {
        if (r == null) {
          emit(QrCodeScanPageStateFailure('No records found for this QR'));
        } else {
          emit(QrCodeScanPageStateAppointment(r));
        }
      },
    );
  }
}
