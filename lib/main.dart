import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hookadoc_server/core/routes/routes.dart';
import 'package:hookadoc_server/core/theme/theme.dart';
import 'package:hookadoc_server/features/presentation/home%20page/bloc/home_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/profile%20page/bloc/profile_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/qr_code%20scan%20page/bloc/qr_code_scan_page_bloc.dart';
import 'package:hookadoc_server/features/presentation/schedules%20page/bloc/schedules_page_bloc.dart';
import 'package:hookadoc_server/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<HomePageBloc>()),
        BlocProvider(create: (_) => serviceLocator<SchedulesPageBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProfilePageBloc>()),
        BlocProvider(create: (_) => serviceLocator<QrCodeScanPageBloc>()),
      ],

      // create: (context) => SubjectBloc(),
      child: ScreenUtilInit(
        designSize: const Size(392.72727272727275, 803.6363636363636),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.darkTheme,
          routerConfig: Routes.route,
        ),
      ),
    );
  }
}
