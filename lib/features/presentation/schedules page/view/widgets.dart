import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hookadoc_server/core/widgets/common.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:intl/intl.dart';

class SchedulesPageWidgets {
  static Widget scheduleContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white38,
            width: 1.r,
          ),
          bottom: BorderSide(
            color: Colors.white38,
            width: 1.r,
          ),
        ),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25.r)),
      ),
      child: Row(
        children: [
          kText('10:00 AM'),
          kWidth(10.w),
          Expanded(
            child: Transform.scale(
              alignment: Alignment.center,
              origin: Offset.zero,
              scaleY: 1.2,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    bottomLeft: Radius.circular(25.r),
                    // topRight: Radius.circular(25.r),
                    // bottomRight: Radius.circular(25.r),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget testExpansionTile({
    required int index,
    required AppointmentEntity appointment,
  }) {
    return _AppointmentContainer(index: index, appointment: appointment);
  }

  static Widget dateContainer({
    required DateTime date,
    required bool isSelected,
  }) {
    return Transform.rotate(
      angle: math.pi,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: isSelected
              ? Color.fromARGB(255, 203, 76, 67)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            kText(
              date.day.toString(),
              // DateTime.now()
              //     .add(const Duration(days: 7))
              //     .subtract(Duration(days: index))
              //     .day
              //     .toString(),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.white38,
            ),
            kText(
              DateFormat('EEE').format(date),
              // DateFormat('EEE').format(DateTime.now()
              //     .add(const Duration(days: 7))
              //     .subtract(Duration(days: index))),
              color: isSelected ? Colors.white : Colors.white38,
            ),
            const Spacer(),
            CircleAvatar(
              radius: 5.r,
              backgroundColor: isSelected ? Colors.white : Colors.transparent,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _AppointmentContainer extends StatefulWidget {
  final int index;
  final AppointmentEntity appointment;
  const _AppointmentContainer(
      {super.key, required this.index, required this.appointment});

  @override
  State<_AppointmentContainer> createState() => __AppointmentContainerState();
}

class __AppointmentContainerState extends State<_AppointmentContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _rippleAnimationController;
  List<Animation> _rippleAnimation = [];

  late Color randomColor;
  final colors = [
    const Color(0xffFFAD60),
    const Color(0xffd2c4ff),
    const Color(0xff96CEB4),
    const Color(0xffff9186),
  ];

  @override
  void initState() {
    // TODO: implement initState
    randomColor = colors[widget.index % 4];

    _rippleAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _rippleAnimation.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _rippleAnimationController,
          curve: Interval(0.0, 0.8, curve: Curves.easeInOut),
        ),
      ),
    );

    _rippleAnimation.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _rippleAnimationController,
          curve: Interval(0.6, 1.0, curve: Curves.easeInOut),
        ),
      ),
    );

    _rippleAnimationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _rippleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // randomColor = Color(0xffF9DBBA);
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10.h),
      // padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      padding: EdgeInsets.only(
        // top: 10.h,
        bottom: 20.h,
        left: 15.w,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white24, width: 1.r),
          bottom: BorderSide(color: Colors.white24, width: 1.r),
        ),
      ),
      child: Row(
        children: [
          kText(
            DateFormat('hh:mm a').format(widget.appointment.dateTime),
            color: Colors.white60,
            fontSize: 13,
          ),
          kWidth(10.w),
          Expanded(
            child: ExpansionTile(
              title: kText(
                widget.appointment.patientName,
                maxLines: 2,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
              iconColor: Colors.black45,
              collapsedIconColor: Colors.black45,
              childrenPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              collapsedShape: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  bottomLeft: Radius.circular(20.r),
                  // topRight: Radius.circular(20.r),
                  // bottomRight: Radius.circular(20.r),
                ),
              ),
              collapsedBackgroundColor: randomColor,
              backgroundColor: randomColor,
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    'https://pyxis.nymag.com/v1/imgs/40d/2a0/3be48013e5189f724dae18a32a016ccd4f-jake-feature-lede.2x.rsquare.w168.jpg'),
              ),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  bottomLeft: Radius.circular(20.r),
                  // topRight: Radius.circular(20.r),
                  // bottomRight: Radius.circular(20.r),
                ),
              ),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kText(
                              'Disease',
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                            kText(
                              widget.appointment.desease,
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const Spacer(),
                    kWidth(20.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                AnimatedBuilder(
                                    animation: _rippleAnimation[0],
                                    builder: (context, _) {
                                      return AnimatedBuilder(
                                          animation: _rippleAnimation[1],
                                          builder: (context, _) {
                                            return Opacity(
                                              opacity: (1 -
                                                      _rippleAnimation[1].value)
                                                  .toDouble(),
                                              child: Transform.scale(
                                                scale:
                                                    _rippleAnimation[0].value *
                                                        2,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.green
                                                      .withOpacity(0.3),
                                                  radius: 5.r,
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                                CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 5.r,
                                )
                              ],
                            ),
                            const Spacer(),
                            kText(
                              'Pending',
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                kHeight(15.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kText(
                              'Booked on',
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                            kHeight(5.h),
                            kText(
                              '${DateFormat('dd MMM, yyyy').format(widget.appointment.bookDate)}\n${DateFormat('hh:mm a').format(widget.appointment.bookDate)}',
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                    kWidth(20.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            kText(
                              'Scheduled on',
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                            kHeight(5.h),
                            kText(
                              '${DateFormat('dd MMM, yyyy').format(widget.appointment.dateTime)}\n${DateFormat('hh:mm a').format(widget.appointment.dateTime)}',
                              textAlign: TextAlign.end,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                kHeight(15.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            kText(
                              'Paid',
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                            kWidth(10.w),
                            kText(
                              '₹${widget.appointment.feeAmount}',
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const Spacer(),
                    kWidth(40.w),
                    Container(
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black45,
                          width: 2.r,
                        ),
                      ),
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.black45,
                        size: 25.r,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
