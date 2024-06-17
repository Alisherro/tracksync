import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tracksync/utils/helper/common.dart';
import 'package:tracksync/utils/helper/constant.dart';

import 'core/app_route.dart';
import 'core/localization/generated/strings.dart';
import 'core/localization/l10n.dart';
import 'core/resources/styles.dart';
import 'dependencies_injection.dart';
import 'features/auth/presentation/login/cubit/login_cubit.dart';
import 'features/auth/presentation/profile/bloc/user_bloc.dart';

class TrackSyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    log.d(const String.fromEnvironment('ENV'));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(
          create: (_) => sl<UserBloc>()..add(const UserFetch()),
          lazy: false,
        ),
        // BlocProvider(create: (_) => sl<ResultsListCubit>()..initState()),
      ],
      child: OKToast(
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          localizationsDelegates: Strings.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: 1,
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            );
          },
          title: Constants.get.appName,
          theme: themeLight(context),
          darkTheme: themeDark(context),
          locale: const Locale("en"),
          supportedLocales: L10n.all,
          themeMode: ThemeMode.light,
        ),
      ),
    );
  }
}
