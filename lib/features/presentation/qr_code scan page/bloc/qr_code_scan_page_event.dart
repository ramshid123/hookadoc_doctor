part of 'qr_code_scan_page_bloc.dart';

@immutable
sealed class QrCodeScanPageEvent {}

final class QrCodeScanPageEventEvaluateQR extends QrCodeScanPageEvent {
  final String doctorId;
  final String appointmentId;

  QrCodeScanPageEventEvaluateQR(
      {required this.doctorId, required this.appointmentId});
}
