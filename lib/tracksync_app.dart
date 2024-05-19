import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tracksync/features/challenges/presentation/challenges/bloc/challenges_bloc.dart';
import 'package:tracksync/utils/helper/common.dart';
import 'package:tracksync/utils/helper/constant.dart';

import 'core/app_route.dart';
import 'core/localization/generated/strings.dart';
import 'core/localization/l10n.dart';
import 'core/resources/styles.dart';
import 'dependencies_injection.dart';
import 'features/auth/presentation/login/cubit/auth_cubit.dart';
import 'features/auth/presentation/profile/bloc/user_bloc.dart';
import 'features/run/presentation/run_history/cubit/results_list_cubit.dart';

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
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<ChallengesBloc>()..add(ChallengesFetchEvent())),
        BlocProvider(create: (_) => sl<UserBloc>()..add(const UserFetch()),lazy: false,),
        BlocProvider(create: (_) => ResultsListCubit()..initState()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            return MaterialApp.router(
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
            );
          },
        ),
      ),
    );
  }
}
