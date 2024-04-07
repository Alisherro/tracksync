import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/images.dart';
import '../resources/palette.dart';

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
            child: SvgPicture.asset(Images.avatar),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Palette.orangeLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                '234',
                style: TextStyle(
                  fontFamily: 'EurostileRound',
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
