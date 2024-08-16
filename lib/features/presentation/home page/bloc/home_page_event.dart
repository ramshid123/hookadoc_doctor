part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

final class HomePageEventGetTopAppointments extends HomePageEvent {
  final String doctorId;

  HomePageEventGetTopAppointments({required this.doctorId});
}

final class HomePageEventGetCountDatas extends HomePageEvent {
  final String doctorId;

  HomePageEventGetCountDatas({required this.doctorId});
}
