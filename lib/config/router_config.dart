import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracksync/config/app_dependencies.dart';
import 'package:tracksync/domain/use_cases/run_result_use_case.dart';
import 'package:tracksync/domain/use_cases/users_use_case.dart';
import 'package:tracksync/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:tracksync/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:tracksync/presentation/blocs/result_cubit/run_result_cubit.dart';
import 'package:tracksync/presentation/screens/configuration_pages_screen.dart';
import 'package:tracksync/presentation/screens/login_screen.dart';
import 'package:tracksync/presentation/screens/profile_screen.dart';
import '../domain/use_cases/user_use_case.dart';
import '../presentation/blocs/leaderboard_cubit/leaderboard_cubit.dart';
import '../presentation/blocs/results_list_cubit/results_list_cubit.dart';
import '../presentation/blocs/running_map_bloc/running_map_bloc.dart';
import '../presentation/blocs/user_config_bloc/user_config_bloc.dart';
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
        // redirect: (context, state) async {
        //   final SharedPreferences pref = await SharedPreferences.getInstance();
        //   final bool isLoggedIn = (pref.getBool('isMale') != null);
        //   if (isLoggedIn) return '/run';
        //   return null;
        // },
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            child: LoginScreen(),
            create: (c) => LoginCubit(
              Provider.of<UserUseCase>(context),
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
              create: (c) => RegisterCubit(
                    context.read<UserUseCase>(),
                  ),
              child:  RegistrationScreen()),
        ),
        path: '/registration',
      ),
      GoRoute(
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: BlocProvider(
            create: (BuildContext context) => UserConfigBloc(),
            child: const ConfigurationPagesScreen(),
          ),
        ),
        path: '/config',
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
                      RunningMapBloc(Provider.of<RunResultUseCase>(context))
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
                  child:  const RunningMapScreen(),
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
                        ResultsListCubit(Provider.of<RunResultUseCase>(context))
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
                        create: (_) => RunResultCubit(
                            Provider.of<RunResultUseCase>(context),
                            state.pathParameters["id"]!)
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
                        LeaderboardCubit(Provider.of<UsersUseCase>(context))
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
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
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
                  ]),
            ],
          )
        ],
      ),
    ],
  );
}
