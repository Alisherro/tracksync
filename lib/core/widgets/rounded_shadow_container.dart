import 'package:flutter/material.dart';

import '../resources/palette.dart';

class RoundedShadowContainer extends StatelessWidget {
  const RoundedShadowContainer(
      {super.key, required this.child, this.backgroundColor});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: backgroundColor?? Palette.background,
            boxShadow: [
              BoxShadow(
                color: Palette.black.withAlpha(10),
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            borderRadius: BorderRadius.circular(12)),
        child: child);
  }
}
