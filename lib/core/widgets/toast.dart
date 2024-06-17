import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final IconData? icon;
  final Color? bgColor;
  final Color? textColor;
  final String? message;

  const Toast(
      {super.key, this.icon, this.bgColor, this.message, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: textColor,
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Text(
                  message!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: textColor),
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
