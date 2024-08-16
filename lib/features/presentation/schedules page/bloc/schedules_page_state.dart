part of 'schedules_page_bloc.dart';

@immutable
sealed class SchedulesPageState {}

final class SchedulesPageInitial extends SchedulesPageState {}

final class SchedulesPageStateSelectedDate extends SchedulesPageState {
  final DateTime date;

  SchedulesPageStateSelectedDate(this.date);
}
