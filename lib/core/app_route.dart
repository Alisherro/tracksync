import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/core/widgets/scaffold_with_bottom_nav_bar.dart';
import 'package:tracksync/features/auth/auth.dart';
import 'package:tracksync/features/run/presentation/run_result/cubit/run_result_cubit.dart';

import '../dependencies_injection.dart';
import '../features/auth/presentation/profile/profile_screen.dart';
import '../features/group/presentation/community_screen.dart';
import '../features/group/presentation/create_group_screen.dart';
import '../features/group/presentation/group_screen.dart';
import '../features/group/presentation/groups_list_screen.dart';
import '../features/group/presentation/groups_screen.dart';
import '../features/group/presentation/invitation_screen.dart';
import '../features/leaderboard/presentation/leaderboard/cubit/leaderboard_cubit.dart';
import '../features/leaderboard/presentation/leaderboard/leaderboards_screen.dart';
import '../features/run/presentation/run_history/cubit/results_list_cubit.dart';
import '../features/run/presentation/run_history/health_tracker_screen.dart';
import '../features/run/presentation/run_result/run_result_screen.dart';
import '../features/run/presentation/running_map/bloc/running_map_bloc.dart';
import '../features/run/presentation/running_map/running_map_screen.dart';

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
    initialLocation: '/run',
    routes: [
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const LoginScreen(),
        ),
        path: '/',
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
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: BlocProvider<ResultsListCubit>(
                    key: UniqueKey(),
                    child: const HealthTrackerScreen(),
                    create: (_) => ResultsListCubit()..initState(),
                  ),
                ),
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
                path: '/groups',
                pageBuilder: (context, state) => buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const GroupsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'create',
                    pageBuilder: (context, state) =>
                        buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const CreateGroupScreen(),
                    ),
                    routes: [
                      GoRoute(
                        path: 'group',
                        pageBuilder: (context, state) =>
                            buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const GroupScreen(),
                        ),
                        routes: [
                          GoRoute(
                            path: 'invitation',
                            pageBuilder: (context, state) =>
                                buildPageWithDefaultTransition(
                              context: context,
                              state: state,
                              child: const InvitationScreen(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'community',
                    pageBuilder: (context, state) =>
                        buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const CommunityScreen(),
                    ),
                  )
                ],
              )
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
                routes: [
                  GoRoute(
                    pageBuilder: (context, state) =>
                        buildPageWithDefaultTransition(
                      context: context,
                      state: state,
                      child: const GroupsListScreen(),
                    ),
                    path: 'groups',
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ],
  );
}
