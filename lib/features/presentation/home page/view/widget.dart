import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/common.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:intl/intl.dart';

class HomePageWidgets {
  static Widget dataButton({
    required Color color,
    required String value,
    required String text,
  }) =>
      Expanded(
        child: Container(
          padding: EdgeInsets.all(15.r),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kText(
                value,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
              kHeight(10.h),
              kText(
                text,
                color: Colors.black,
                fontSize: 11,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      );

  static Widget appointmentContainer(AppointmentEntity appointment) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: ColorConstants.containerColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ41IpKr1jnu6Tv6RfKrfMTprCpYAVEWz2pQ&s',
                ),
              ),
              kWidth(15.w),
              Expanded(
                child: kText(
                  // 'Ramshid Dilhan',
                  appointment.patientName,
                  maxLines: 2,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          kHeight(15.h),
          kText(
            'Took appointment on\n${DateFormat('d MMM, yyyy').format(appointment.bookDate)}',
            // appointment.note.isNotEmpty
            //     ? appointment.note
            //     : (appointment.desease == 'Others'
            //         ? 'Non-disclosed Disease'
            //         : appointment.desease),
            maxLines: 2,
            textAlign: TextAlign.start,
            color: ColorConstants.whiteColor.withOpacity(0.4),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Colors.black87,
                ),
                child: Column(
                  children: [
                    kText(
                      DateTime(
                                  appointment.dateTime.year,
                                  appointment.dateTime.month,
                                  appointment.dateTime.day) ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                          ? 'Today'
                          : DateFormat('dd/MM/yy').format(appointment.dateTime),
                      // '13/11/2024',
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                    kText(
                      DateFormat('hh:mm a').format(appointment.dateTime),
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black87,
                ),
                child: Center(
                  child: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
