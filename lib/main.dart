import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_app/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:github_app/bloc/issue_bloc/issue_bloc_cubit.dart';
import 'package:github_app/bloc/main_bloc/main_bloc_cubit.dart';
import 'package:github_app/bloc/repository_bloc/repository_bloc_cubit.dart';
import 'package:github_app/bloc/user_bloc/user_bloc_cubit.dart';
import 'package:github_app/ui/main/main_page.dart';
import 'package:github_app/utils/setup_get_it.dart';

void main() {
  setup();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => UserBlocCubit()),
        BlocProvider(create: (_) => MainBlocCubit()),
        BlocProvider(create: (_) => IssueBlocCubit()),
        BlocProvider(create: (_) => RepositoryBlocCubit()),
      ], child: const MainPage()),
    );
  }
}
