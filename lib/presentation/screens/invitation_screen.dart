import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/config/constants.dart';
import 'package:tracksync/presentation/widgets/next_button_widget.dart';
import 'package:tracksync/presentation/widgets/pop_button_widget.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 20, left: 40, right: 40, top: 40),
          child: PopButtonWidget(
            title: 'INVITATION',
            onTap: () {
              context.pop();
            },
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: emptyColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
            child: Row(
              children: [
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 80) * 0.60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TELL ABOUT THE GROUP',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      const Text('Invite those who do not use the application'),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                          ),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text('SHARE'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 80) * 0.1,
                ),
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 80) * 0.30,
                  child: SvgPicture.asset(groupTell),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            width: double.infinity,
            child: NextButtonWidget(
              isEnable: true,
              enableCallback: () {},
              disableCallback: () {},
              title: 'Share profile',
            ),
          ),
        )
      ],
    );
  }
}
