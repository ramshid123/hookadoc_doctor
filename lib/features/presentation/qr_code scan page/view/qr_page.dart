import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hookadoc_server/core/routes/route_names.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/common.dart';
import 'package:hookadoc_server/features/presentation/qr_code%20scan%20page/bloc/qr_code_scan_page_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanPage extends StatefulWidget {
  const QrCodeScanPage({super.key});

  @override
  State<QrCodeScanPage> createState() => _QrCodeScanPageState();
}

class _QrCodeScanPageState extends State<QrCodeScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  late QRViewController qrController;

  bool _isSnackbarActive = false;

  void onQrCreated(QRViewController qrController) {
    this.qrController = qrController;
    qrController.scannedDataStream.listen((data) {
      if (data.code != null && data.code!.contains('asdf123')) {
        log('data => ${data.code.toString()}');

        context.read<QrCodeScanPageBloc>().add(QrCodeScanPageEventEvaluateQR(
              appointmentId: 'appointment_id_10',
              doctorId: 'test_doctor_id',
            ));
      } else if (!_isSnackbarActive) {
        _isSnackbarActive = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(theSnackBar('Invalid QR Code'))
            .closed
            .then((_) {
          _isSnackbarActive = false;
        });
      }
    });
  }

  SnackBar theSnackBar(String message) {
    return SnackBar(
      content: kText(
        message,
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: ColorConstants.redColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<QrCodeScanPageBloc, QrCodeScanPageState>(
      listener: (context, state) {
        if (state is QrCodeScanPageStateFailure && !_isSnackbarActive) {
          _isSnackbarActive = true;
          ScaffoldMessenger.of(context)
              .showSnackBar(theSnackBar(state.errorMessage))
              .closed
              .then((_) {
            _isSnackbarActive = false;
          });
        } else if (state is QrCodeScanPageStateAppointment) {
          qrController.stopCamera();
          qrController.dispose();
          context.go(RouteNames.homePage);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: Column(
          children: [
            kHeight(70.h),
            kWidth(double.infinity),
            kText(
              'Scan Patient\'s QR',
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            Container(
              height: size.width - 100.w,
              width: size.width - 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: onQrCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: ColorConstants.redColor,
                    borderRadius: 20.r,
                    borderWidth: 10.r,
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => context.go(RouteNames.homePage),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: ColorConstants.redColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: kText(
                    'Back to Home',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            kHeight(100.h),
          ],
        ),
      ),
    );
  }
}
