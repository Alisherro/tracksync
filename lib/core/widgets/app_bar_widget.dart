import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/auth/presentation/profile/bloc/user_bloc.dart';
import '../resources/images.dart';
import 'avatar_circle_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.onProfileTap});

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if(state is UserAuthenticated){
                  return AvatarCircleWidget(
                    diameter: kToolbarHeight-5,
                    imageUrl: state.user.profilePicture,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // DecoratedBox(
          //   decoration: BoxDecoration(
          //     color: Palette.orangeLight,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: const Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          //     child: Text(
          //       '234',
          //       style: TextStyle(
          //         fontFamily: 'EurostileRound',
          //         fontWeight: FontWeight.w900,
          //         fontSize: 20,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
