import 'package:flutter/material.dart';
import 'package:tracksync/core/core.dart';

class PopButtonWidget extends StatelessWidget {
  const PopButtonWidget({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Palette.text,
          ),
          const SizedBox(width: 14),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
