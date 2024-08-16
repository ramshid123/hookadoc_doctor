import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hookadoc_server/core/constants/firestore_collections.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/bottom_nav_bar.dart';
import 'package:hookadoc_server/core/widgets/common.dart';
import 'package:hookadoc_server/features/data/models/appointment_model.dart';
import 'package:hookadoc_server/features/presentation/schedules%20page/bloc/schedules_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/schedules%20page/view/widgets.dart';
import 'package:intl/intl.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scrollAnimationController;

  final scrollController = ScrollController();

  int index = math.Random().nextInt(4);

  @override
  void initState() {
    // TODO: implement initState
    _scrollAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SchedulesPageBloc, SchedulesPageState>(
      builder: (context, state) {
        DateTime selectedDay = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        if (state is SchedulesPageStateSelectedDate) {
          selectedDay = state.date;
          log(state.date.toString());
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(size.width, 250.h),
            child: SafeArea(
              child: Column(
                children: [
                  kHeight(5.h),
                  kText(
                    'Schedules',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  kHeight(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            kText(
                              DateFormat('MMMM dd').format(selectedDay),
                              // 'August 19',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            kHeight(5.h),
                            kText(
                              '10 patients',
                              color: Colors.white54,
                              fontSize: 15,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.r, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: ColorConstants.redColor,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            children: [
                              kText(
                                'Latest',
                                fontWeight: FontWeight.w600,
                              ),
                              kWidth(5.w),
                              Icon(
                                Icons.sort,
                                size: 15.r,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight(10.h),
                  // const Spacer(),
                  Expanded(
                    child: Transform.rotate(
                      angle: math.pi,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          _scrollAnimationController.stop();
                          _scrollAnimationController.reverse();
                          final date = DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                              .subtract(Duration(days: index));
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<SchedulesPageBloc>()
                                  .add(SchedulesPageEventSelectDate(date));
                            },
                            child: SchedulesPageWidgets.dateContainer(
                                date: date, isSelected: date == selectedDay),
                          );
                        },
                      ),
                    ),
                  ),
                  // kHeight(20.h),
                  Transform.translate(
                    offset: Offset(0.0, 5.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        kWidth(15.w),
                        kText('10:00 AM', color: Colors.transparent),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 5.r,
                                backgroundColor: ColorConstants.redColor,
                              ),
                              Expanded(
                                child: Container(
                                  color: ColorConstants.redColor,
                                  height: 2.r,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              FirestoreListView(
                controller: scrollController,
                query: FirebaseFirestore.instance
                    .collection(FirestoreCollections.appointments)
                    .where('doctorId', isEqualTo: 'test_doctor_id')
                    .where('dateTime',
                        isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(
                            selectedDay.year,
                            selectedDay.month,
                            selectedDay.day)))
                    .where('dateTime',
                        isLessThan: Timestamp.fromDate(DateTime(
                                selectedDay.year,
                                selectedDay.month,
                                selectedDay.day)
                            .add(Duration(days: 1)))),
                itemBuilder: (context, item) {
                  index++;
                  return SchedulesPageWidgets.testExpansionTile(
                      index: index,
                      appointment: AppointmentModel.fromJson(item));
                },
                emptyBuilder: (context) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: kText(
                        'No Records',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white38,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context) {
                  return Center(
                    child: SizedBox(
                      height: 60.r,
                      width: 60.r,
                      child: const CircularProgressIndicator(
                        color: ColorConstants.redColor,
                      ),
                    ),
                  );
                },
              ),
              kustomBottomNavBar(
                index: 1,
                animationController: _scrollAnimationController,
                scrollController: scrollController,
              ),
            ],
          ),
        );
      },
    );
  }
}
