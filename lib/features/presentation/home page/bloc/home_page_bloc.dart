import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hookadoc_server/features/domain/entities/appointment_entity.dart';
import 'package:hookadoc_server/features/domain/entities/count_data_entity.dart';
import 'package:hookadoc_server/features/domain/usecases/get_all_appointments.dart';
import 'package:hookadoc_server/features/domain/usecases/get_count_data.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UsecaseGetAllAppointments _usecaseGetAllAppointments;
  final UsecaseGetCountDatas _usecaseGetCountDatas;

  HomePageBloc(
      {required UsecaseGetAllAppointments usecaseGetAllAppointments,
      required UsecaseGetCountDatas usecaseGetCountDatas})
      : _usecaseGetAllAppointments = usecaseGetAllAppointments,
        _usecaseGetCountDatas = usecaseGetCountDatas,
        super(HomePageInitial()) {
    on<HomePageEventGetTopAppointments>((event, emit) async =>
        await _onHomePageEventGetTopAppointments(event, emit));

    on<HomePageEventGetCountDatas>((event, emit) async =>
        await _onHomePageEventGetCountDatas(event, emit));
  }

  Future _onHomePageEventGetCountDatas(
      HomePageEventGetCountDatas event, Emitter<HomePageState> emit) async {
    final response = await _usecaseGetCountDatas(
        UsecaseGetCountDatasParams(doctorId: event.doctorId));

    response.fold(
      (l) => emit(HomePageStateFailure(l.failureMessage)),
      (r) => emit(HomePageStateCountDatas(countData: r)),
    );
  }

  Future _onHomePageEventGetTopAppointments(
      HomePageEventGetTopAppointments event,
      Emitter<HomePageState> emit) async {
    final response = await _usecaseGetAllAppointments(
        UsecaseGetAllAppointmentsParams(doctorId: event.doctorId, count: 6));

    response.fold(
      (l) => emit(HomePageStateFailure(l.failureMessage)),
      (r) {
        log('length => ${r.length}');
        emit(HomePageStateAppointments(r));
      },
    );
  }
}
