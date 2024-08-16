import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hookadoc_server/features/data/datasources/remote_datasource.dart';
import 'package:hookadoc_server/features/data/repository/repository.dart';
import 'package:hookadoc_server/features/domain/repository/repository.dart';
import 'package:hookadoc_server/features/domain/usecases/get_all_appointments.dart';
import 'package:hookadoc_server/features/domain/usecases/get_appointment_by_id.dart';
import 'package:hookadoc_server/features/domain/usecases/get_count_data.dart';
import 'package:hookadoc_server/features/presentation/home%20page/bloc/home_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/profile%20page/bloc/profile_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/qr_code%20scan%20page/bloc/qr_code_scan_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/schedules%20page/bloc/schedules_page_bloc.dart';
import 'package:hookadoc_server/firebase_options.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestoreDB = FirebaseFirestore.instance;

  serviceLocator.registerLazySingleton(() => firestoreDB);

  _initHomepageBloc();
}

void _initHomepageBloc() {
  serviceLocator
    ..registerFactory<RemoteDatasource>(
        () => RemoteDataSourceImpl(serviceLocator()))
    ..registerFactory<AppointmentRepository>(
        () => AppointmentRepositoryImpl(serviceLocator()))
    ..registerFactory<UsecaseGetAllAppointments>(
        () => UsecaseGetAllAppointments(serviceLocator()))
    ..registerFactory<UsecaseGetCountDatas>(
        () => UsecaseGetCountDatas(serviceLocator()))
    ..registerFactory<UsecaseGetAppointmentById>(
        () => UsecaseGetAppointmentById(serviceLocator()))
    ..registerLazySingleton<HomePageBloc>(() => HomePageBloc(
          usecaseGetAllAppointments: serviceLocator(),
          usecaseGetCountDatas: serviceLocator(),
        ))
    ..registerLazySingleton(() => SchedulesPageBloc())
    ..registerLazySingleton(() => ProfilePageBloc())
    ..registerLazySingleton(() => QrCodeScanPageBloc(
          usecaseGetAppointmentById: serviceLocator(),
        ));
}
