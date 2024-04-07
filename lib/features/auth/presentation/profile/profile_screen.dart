import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/core.dart';
import '../../domain/entities/user.dart';
import 'bloc/user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            final User user = state.user;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          SvgPicture.asset(
                            Images.avatar,
                            width: 100,
                            height: 100,
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
                                Text(user.isMale ?? false ? 'Female' : 'Male',
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                          ),
                          SvgPicture.asset(Images.edit),
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
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Palette.secondColor,
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Text(
                              '234',
                              style: TextStyle(
                                  fontFamily: 'EurostileRound',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                RoundedShadowContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 33, horizontal: 40),
                    child: Row(
                      children: [
                        Text(
                          '1',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'EurostileRound',
                                    color: Palette.orangeColor,
                                  ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TurBo777',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              '99 level',
                              style: TextStyle(
                                color: Palette.orangeColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          '1 456 643',
                          style: TextStyle(
                              color: Palette.orangeColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              fontFamily: 'EurostileRound'),
                        )
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
                const InfoSectionWidget(
                  title: 'WEIGHT',
                  subtitle: Text(
                    '182 lb.',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'EurostileRound'),
                  ),
                ),
                const SizedBox(height: 5),
                const InfoSectionWidget(
                  title: 'HEIGHT',
                  subtitle: Text(
                    '5\'11\'\'',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        fontFamily: 'EurostileRound'),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: ButtonText(
                    onPressed: () {
                      context.read<UserBloc>().add(const UserLogOut());
                    },
                    title: 'Logout',
                    titleColor: Palette.redLatte,
                  ),
                )
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
