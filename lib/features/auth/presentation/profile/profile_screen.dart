import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/core/widgets/avatar_circle_widget.dart';
import 'package:tracksync/utils/ext/ext.dart';
import '../../../../core/core.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../../domain/entities/user.dart';
import 'bloc/user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<UserBloc, UserState>(
        listener: (_, state) {
          switch (state) {
            case SLoading():
              context.show();
              break;
            case SFailed():
              context.dismiss();
              state.error?.toToastError(context);
              break;
            case SSuccess():
              context.dismiss();
              state.message?.toToastSuccess(context);
            case UserLoading():
            case UserAuthenticated():
            case UserUnauthenticated():
          }
        },
        buildWhen: (prev, cur) {
          return [UserLoading, UserAuthenticated, UserUnauthenticated]
              .contains(cur.runtimeType);
        },
        builder: (context, state) {
          if (state is UserAuthenticated) {
            final User user = state.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Text(
                        'PROFILE',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        children: [
                          AvatarCircleWidget(
                            diameter: 100,
                            imageUrl: user.profilePicture,
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.name ?? 'UserName',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                FittedBox(
                                  child: Text(
                                    'nick',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: Palette.redColor,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                                Text(
                                  user.isMale ?? false ? 'Female' : 'Male',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: SvgPicture.asset(Images.edit),
                            onTap: () {
                              context
                                  .read<UserBloc>()
                                  .add(const UserChangeProfilePicture());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                RoundedShadowContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'tracksync',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const InfoSectionWidget(
                  title: 'LOCATION',
                  subtitle: Text(
                    'Kazakhstan, Astana',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 5),
                InfoSectionWidget(
                  title: 'WEIGHT',
                  subtitle: Text(
                    user.weight != null ? '${user.weight} kg' : 'unknown',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'EurostileRound'),
                  ),
                ),
                const SizedBox(height: 5),
                InfoSectionWidget(
                  title: 'HEIGHT',
                  subtitle: Text(
                    user.height != null ? '${user.height} cm' : 'unknown',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'EurostileRound'),
                  ),
                ),
                const SizedBox(height: 5),
                InfoSectionWidget(
                  title: 'BIRTH DATE',
                  subtitle: Text(
                    user.birthDate ?? 'unknown',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'EurostileRound'),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Button(
                    color: Palette.redLatte,
                    onPressed: () {
                      context.read<UserBloc>().add(const UserLogout());
                    },
                    title: 'Logout',
                    titleColor: Palette.redLatte,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: ButtonText(
                    titleColor: Palette.redLatte,
                    onPressed: () async {
                      await showConfirmationDialog(
                        context,
                        confirm: () {
                          context.read<UserBloc>().add(const UserDelete());
                          context.pop();
                        },
                        deny: () {
                          context.pop();
                        },
                        title: 'Are you sure you want to delete your account?',
                      );
                    },
                    title: 'Delete account',
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class InfoSectionWidget extends StatelessWidget {
  const InfoSectionWidget(
      {super.key, required this.title, required this.subtitle});

  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return RoundedShadowContainer(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              subtitle
            ],
          ),
        ),
      ),
    );
  }
}
