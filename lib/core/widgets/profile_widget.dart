import 'package:flutter/material.dart';
import '../../features/auth/domain/entities/user.dart';
import '../widgets/widgets.dart';
import '../resources/resources.dart';
import 'avatar_circle_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const BackButton(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                        style: Theme.of(context).textTheme.titleMedium),
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
            ],
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
      ],
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
