import 'package:flutter/material.dart';

import '../resources/palette.dart';

class DetailSelectButtonWidget extends StatelessWidget {
  const DetailSelectButtonWidget({
    super.key,
    required this.onSelect,
    required this.title,
  });

  final VoidCallback onSelect;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Palette.emptyColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(color: Palette.background),),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  onPressed: onSelect,
                  child: const Text(
                    'Select',
                    style: TextStyle(color: Palette.sunsetOrange),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
