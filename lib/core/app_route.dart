import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/core/widgets/scaffold_with_bottom_nav_bar.dart';
import 'package:tracksync/features/auth/domain/repositories/user_repository.dart';
import 'package:tracksync/features/run/presentation/run_result/cubit/run_result_cubit.dart';
import '../dependencies_injection.dart';
import '../features/auth/presentation/configuration/bloc/user_config_bloc.dart';
import '../features/auth/presentation/configuration/configuration_screen.dart';
import '../features/auth/presentation/login/login_screen.dart';
import '../features/auth/presentation/profile/bloc/user_bloc.dart';
import '../features/auth/presentation/profile/profile_screen.dart';
import '../features/auth/presentation/register/cubit/register_cubit.dart';
import '../features/auth/presentation/register/register_screen.dart';
import '../features/auth/presentation/splash/splash_screen.dart';
import '../features/challenges/presentation/challenges/bloc/challenges_bloc.dart';
import '../features/challenges/presentation/challenges/challenges_screen.dart';
import '../features/leaderboard/presentation/leaderboard/cubit/leaderboard_cubit.dart';
import '../features/leaderboard/presentation/leaderboard/leaderboards_screen.dart';
import '../features/run/presentation/run_history/cubit/results_list_cubit.dart';
import '../features/run/presentation/run_history/health_tracker_screen.dart';
import '../features/run/presentation/run_result/run_result_screen.dart';
import '../features/run/presentation/running_map/bloc/running_map_bloc.dart';
import '../features/run/presentation/running_map/running_map_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  UserState? state;

  GoRouterRefreshStream(Bloc bloc) {
    _subscription = bloc.stream.asBroadcastStream().listen(
      (dynamic userState) {
        if (state == userState) {
        } else {
          notifyListeners();
        }
        state = userState;
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _sectionNavigatorKey = GlobalKey<NavigatorState>();

  static CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(sl<UserBloc>()),
    redirect: (context, state) async {
      UserState userState = context.read<UserBloc>().state;
      if (userState is UserAuthenticated) {
        if ([
          '/run',
          '/health',
          '/leaderboard',
          '/challenges',
          '/profile',
        ].any((element) => state.matchedLocation.startsWith(element))) {
          if (userState.user.height == null) {
            return '/configuration';
          }

          return null;
        } else {
          return userState.user.height == null ? '/configuration' : '/run';
        }
      } else if (userState is UserUnauthenticated) {
        if (['/login', '/registration'].contains(state.matchedLocation)) {
          return null;
        } else {
          return '/login';
        }
      }
      return null;
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            child: const ConfigurationPagesScreen(),
            create: (_) => UserConfigBloc(sl<UserRepository>()),
          ),
        ),
        path: '/configuration',
      ),
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const SplashScreen(),
        ),
        path: '/',
      ),
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
        path: '/login',
      ),
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (c) => sl<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        ),
        path: '/registration',
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<RunningMapBloc>()),
                BlocProvider(
                    create: (_) => sl<ChallengesBloc>()..add(ChallengesFetchEvent())),
                BlocProvider(create: (_) => sl<ResultsListCubit>()..initState()),


              ],
              child: ScaffoldWithBottomNavBar(
                navigationShell: navigationShell,
              ),
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: [
              GoRoute(
                path: '/run',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const RunningMapScreen(),
                ),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/health',
                pageBuilder: (context, state) {
                  return buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const HealthTrackerScreen());
                },
                routes: [
                  GoRoute(
                    path: 'result/:id',
                    pageBuilder: (context, state) =>
                        buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: BlocProvider<RunResultCubit>(
                        key: UniqueKey(),
                        create: (_) =>
                            RunResultCubit(state.pathParameters["id"]!)
                              ..initState(),
                        child: const RunResultScreen(),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/leaderboard',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: BlocProvider<LeaderboardCubit>(
                    create: (_) => sl<LeaderboardCubit>(),
                    child: const LeaderboardsScreen(),
                  ),
                ),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/challenges',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const ChallengesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const ProfileScreen(),
                ),
                path: '/profile',
              ),
            ],
          )
        ],
      ),
    ],
  );
}
