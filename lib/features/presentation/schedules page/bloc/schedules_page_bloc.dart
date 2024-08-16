import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'schedules_page_event.dart';
part 'schedules_page_state.dart';

class SchedulesPageBloc extends Bloc<SchedulesPageEvent, SchedulesPageState> {
  SchedulesPageBloc() : super(SchedulesPageInitial()) {
    on<SchedulesPageEventSelectDate>((event, emit) {
      _onSchedulesPageEventSelectDate(event, emit);
    });

    // on<SchedulesPageEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  void _onSchedulesPageEventSelectDate(
      SchedulesPageEventSelectDate event, Emitter<SchedulesPageState> emit) {
    emit(SchedulesPageStateSelectedDate(event.date));
  }

  @override
  void onChange(Change<SchedulesPageState> change) {
    // TODO: implement onChange
    log(change.toString());
    super.onChange(change);
  }
}
