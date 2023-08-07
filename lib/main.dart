import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tracksync/config/app_dependencies.dart';
import 'package:tracksync/config/app_theme.dart';
import 'package:tracksync/config/router_config.dart';

import 'config/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyGlobalObserver();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: AppDependencies.provideRunResultUseCase(),
        ),
        Provider.value(
          value: AppDependencies.provideUsersUseCase(),
        ),
        Provider.value(
          value: AppDependencies.provideUserUseCase(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Flutter App',
        theme: AppTheme.themeData,
      ),
    );
  }
}
