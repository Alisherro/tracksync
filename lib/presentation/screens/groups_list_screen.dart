import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tracksync/presentation/widgets/pop_button_widget.dart';

import '../../core/resources/images.dart';
import '../../core/resources/palette.dart';

class GroupsListScreen extends StatelessWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: PopButtonWidget(
            title: 'GROUPS (1)',
            onTap: () {
              context.pop();
            },
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Palette.emptyColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'MY GROUPS (1)',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'EurostileRound',
                      fontWeight: FontWeight.w900,
                    ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(Images.runGroup),
                      radius: 24,
                    ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NFT run guys',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                          const Text(
                            '2 Member',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Palette.orangeColor),
                        )
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_outlined,
                      color: Palette.redColor,
                    )
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ]
            ),
          ),
        )
      ],
    );
  }
}
