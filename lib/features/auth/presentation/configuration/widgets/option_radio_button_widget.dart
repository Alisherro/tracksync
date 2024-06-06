import 'package:flutter/material.dart';

import '../../../../../core/resources/palette.dart';

class OptionRadioButtonWidget extends StatelessWidget {
  const OptionRadioButtonWidget(
      {super.key,
        required this.child,
        required this.isSelected,
        required this.onTap});

  final Widget child;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isSelected ? Palette.sunsetOrange : Palette.emptyColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                child,
                Radio(
                  splashRadius: 0,
                  value: isSelected,
                  groupValue: true,
                  onChanged: (_) {
                    onTap();
                  },
                  fillColor: const MaterialStatePropertyAll(Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}