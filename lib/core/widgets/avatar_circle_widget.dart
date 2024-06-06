import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../resources/images.dart';

class AvatarCircleWidget extends StatelessWidget {
  const AvatarCircleWidget({super.key, required this.diameter, this.imageUrl});

  final String? imageUrl;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    if (imageUrl!=null) {
      return CachedNetworkImage(
        imageUrl:
        "http://77.91.75.55/storage/$imageUrl",
        fit: BoxFit.contain,
        imageBuilder: (context, imageProvider) => SizedBox(
          height: diameter,
          width: diameter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return SvgPicture.asset(Images.maleAvatar);
  }
}
