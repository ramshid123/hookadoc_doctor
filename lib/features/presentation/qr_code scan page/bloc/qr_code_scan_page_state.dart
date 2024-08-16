part of 'qr_code_scan_page_bloc.dart';

@immutable
sealed class QrCodeScanPageState {}

final class QrCodeScanPageStateInitial extends QrCodeScanPageState {}

final class QrCodeScanPageStateFailure extends QrCodeScanPageState {
  final String errorMessage;

  QrCodeScanPageStateFailure(this.errorMessage);
}

final class QrCodeScanPageStateAppointment extends QrCodeScanPageState {
  final AppointmentEntity appointment;

  QrCodeScanPageStateAppointment(this.appointment);
}
