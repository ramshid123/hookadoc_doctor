import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hookadoc_server/core/theme/palette.dart';
import 'package:hookadoc_server/core/widgets/bottom_nav_bar.dart';
import 'package:hookadoc_server/core/widgets/common.dart';
import 'package:hookadoc_server/features/presentation/home%20page/bloc/home_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/home%20page/view/temp.dart';
import 'package:hookadoc_server/features/presentation/home%20page/view/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState

    context
        .read<HomePageBloc>()
        .add(HomePageEventGetTopAppointments(doctorId: 'test_doctor_id'));

    context
        .read<HomePageBloc>()
        .add(HomePageEventGetCountDatas(doctorId: 'test_doctor_id'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is HomePageStateFailure) {
          log('Something went wrong => ${state.failureMessage}');
        }
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     await Temp().addDummyAppointments();
            //   },
            // ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight(5.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.containerColor,
                            ),
                            child: Icon(
                              Icons.menu,
                              size: 30.r,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstants.containerColor,
                            ),
                            child: Icon(
                              Icons.notifications,
                              size: 30.r,
                            ),
                          ),
                          kWidth(10.w),
                          CircleAvatar(
                            radius: 20.r,
                          ),
                        ],
                      ),
                      kHeight(40.h),
                      kText(
                        'Welcome',
                        fontSize: 20,
                      ),
                      kHeight(5.h),
                      kText(
                        'Ramsheed',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      kHeight(30.h),
                      BlocBuilder<HomePageBloc, HomePageState>(
                        buildWhen: (previous, current) =>
                            current is HomePageStateCountDatas ? true : false,
                        builder: (context, state) {
                          if (state is! HomePageStateCountDatas) {
                            return Container();
                          }

                          return Row(
                            children: [
                              HomePageWidgets.dataButton(
                                  text: 'Today',
                                  value: state.countData.today.toString(),
                                  color: const Color(0xffd2c4ff)),
                              HomePageWidgets.dataButton(
                                  text: 'Pending',
                                  value: state.countData.pending.toString(),
                                  color: const Color(0xffFFAD60)),
                              HomePageWidgets.dataButton(
                                  text: 'Done',
                                  value: state.countData.done.toString(),
                                  color: const Color(0xff96CEB4)),
                              HomePageWidgets.dataButton(
                                  text: 'Missed',
                                  value: state.countData.missed.toString(),
                                  color: const Color(0xffff9186)),
                            ],
                          );
                        },
                      ),
                      // GridView.count(
                      //   crossAxisCount: 2,
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   mainAxisSpacing: 10.h,
                      //   crossAxisSpacing: 10.w,
                      //   children: [
                      //     HomePageWidgets.dataButton(),
                      //     HomePageWidgets.dataButton(),
                      //     HomePageWidgets.dataButton(),
                      //     HomePageWidgets.dataButton(),
                      //   ],
                      // ),
                      // Wrap(
                      //   children: [
                      //     for (int i = 0; i < 4; i++) HomePageWidgets.dataButton(),
                      //   ],
                      // ),
                      kHeight(20.h),
                      Row(
                        children: [
                          kText(
                            'Pending Appointments',
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => context.read<HomePageBloc>().add(
                                HomePageEventGetTopAppointments(
                                    doctorId: 'test_doctor_id')),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              child: Icon(
                                Icons.refresh,
                                color: ColorConstants.liteWhiteColor,
                                size: 25.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeight(20.h),
                      BlocBuilder<HomePageBloc, HomePageState>(
                        buildWhen: (previous, current) =>
                            current is HomePageStateAppointments ? true : false,
                        builder: (context, state) {
                          if (state is! HomePageStateAppointments) {
                            return Container();
                          }

                          return GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.w,
                            children: [
                              for (var appointment in state.appointments)
                                HomePageWidgets.appointmentContainer(
                                    appointment),
                            ],
                          );
                        },
                      ),
                      kHeight(20.h),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: ColorConstants.containerColor,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              kText(
                                'View All',
                              ),
                              kWidth(10.w),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                                size: 20.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      kHeight(100.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          kustomBottomNavBar(
            index: 0,
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}
