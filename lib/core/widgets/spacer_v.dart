import 'package:flutter/material.dart';
import 'package:tracksync/core/core.dart';

class SpacerV extends StatelessWidget {
  const SpacerV({super.key, this.value});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value ?? Dimens.space8,
    );
  }
}
