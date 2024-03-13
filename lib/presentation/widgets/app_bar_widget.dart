import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/resources/images.dart';
import '../../core/resources/palette.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.onProfileTap});

  String gpsConnection(int connection) {
    return '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
  <path d="M2 20H2.01" stroke="#${connection >= 1 ? '2FDA9C' : 'E1E1E1'}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M7 20V16" stroke="#${connection >= 2 ? '2FDA9C' : 'E1E1E1'}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M12 20V12" stroke="#${connection >= 3 ? '2FDA9C' : 'E1E1E1'}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M17 20V8" stroke="#${connection >= 4 ? '2FDA9C' : 'E1E1E1'}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M22 4V20" stroke="#${connection >= 5 ? '2FDA9C' : 'E1E1E1'}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''';
  }

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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'GPS',
                style: TextStyle(
                  color: Palette.greenColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.string(gpsConnection(3)),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Palette.secondColor,
              borderRadius: BorderRadius.circular(38),
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
