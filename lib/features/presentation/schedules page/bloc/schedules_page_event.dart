part of 'schedules_page_bloc.dart';

@immutable
sealed class SchedulesPageEvent {}

final class SchedulesPageEventSelectDate extends SchedulesPageEvent {
  final DateTime date;

  SchedulesPageEventSelectDate(this.date);
}
