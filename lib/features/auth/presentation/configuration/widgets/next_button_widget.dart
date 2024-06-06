import 'package:flutter/material.dart';


class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({
    super.key,
    required this.isEnable,
    required this.enableCallback,
    required this.disableCallback,
    this.title,
  });

  final bool isEnable;
  final VoidCallback enableCallback;
  final VoidCallback disableCallback;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: MaterialStatePropertyAll(
            isEnable ? Colors.blue : Colors.grey),
      ),
      onPressed: isEnable ? enableCallback : disableCallback,
      child: Text(
        title ?? 'Next',
        style: TextStyle(
          color: isEnable ? Colors.white : Colors.white.withOpacity(0.2),
        ),
      ),
    );
  }
}