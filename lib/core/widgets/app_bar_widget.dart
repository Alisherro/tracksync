import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../features/auth/presentation/profile/bloc/user_bloc.dart';
import '../resources/images.dart';
import '../resources/palette.dart';
import 'avatar_circle_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.onProfileTap});

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if(state is UserAuthenticated){
            final user = state.user;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onProfileTap,
                  child: AvatarCircleWidget(
                    diameter: kToolbarHeight - 5,
                    imageUrl: user.profilePicture,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Palette.orangeLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      '${user.coins??0}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            );

          }else{
            return SizedBox.shrink();
          }
          },
      ),
    );
  }
}
