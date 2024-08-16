part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageStateFailure extends HomePageState {
  final String failureMessage;

  HomePageStateFailure(this.failureMessage);
}

final class HomePageStateAppointments extends HomePageState {
  final List<AppointmentEntity> appointments;

  HomePageStateAppointments(this.appointments);
}

final class HomePageStateCountDatas extends HomePageState {
  final CountDataEntity countData;

  HomePageStateCountDatas({required this.countData});
}
