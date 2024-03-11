import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracksync/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:tracksync/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:tracksync/presentation/blocs/result_cubit/run_result_cubit.dart';
import 'package:tracksync/presentation/screens/login_screen.dart';
import 'package:tracksync/presentation/screens/profile_screen.dart';
import '../presentation/blocs/leaderboard_cubit/leaderboard_cubit.dart';
import '../presentation/blocs/results_list_cubit/results_list_cubit.dart';
import '../presentation/blocs/running_map_bloc/running_map_bloc.dart';
import '../presentation/screens/community_screen.dart';
import '../presentation/screens/create_group_screen.dart';
import '../presentation/screens/group_screen.dart';
import '../presentation/screens/groups_list_screen.dart';
import '../presentation/screens/groups_screen.dart';
import '../presentation/screens/health_tracker_screen.dart';
import '../presentation/screens/invitation_screen.dart';
import '../presentation/screens/leaderboards_screen.dart';
import '../presentation/screens/registration_screen.dart';
import '../presentation/screens/run_result_screen.dart';
import '../presentation/screens/running_map_screen.dart';
import '../presentation/screens/scaffold_with_bottom_nav_bar.dart';

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
    initialLocation: '/',
    routes: [
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            child: const LoginScreen(),
            create: (c) => LoginCubit(
            ),
          ),
        ),
        path: '/',
      ),
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (c) => RegisterCubit(),
            child: const RegistrationScreen(),
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
                BlocProvider(
                  create: (_) =>
                      RunningMapBloc()
                        ..add(InitPermissions()),
                )
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
                    create: (_) =>
                        ResultsListCubit()
                          ..initState(),
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
                        create: (_) => RunResultCubit(state.pathParameters["id"]!)
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
                    create: (_) =>
                        LeaderboardCubit()
                          ..initData(),
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
