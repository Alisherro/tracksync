import 'package:flutter/material.dart';

import '../../core/resources/palette.dart';

class DiscoveryButtonWidget extends StatelessWidget {
  const DiscoveryButtonWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap,
      required this.buttonText});

  final String title;
  final String subtitle;
  final Widget icon;
  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(color: Palette.redColor, width: 2),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 10),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(Palette.secondColor),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
                textStyle: MaterialStatePropertyAll(
                    Theme.of(context).textTheme.bodySmall),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
              ),
              onPressed: onTap,
              child: Text(buttonText),
            )
          ],
        ),
      ),
    );
  }
}
