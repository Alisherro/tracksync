import 'package:flutter/material.dart';

import '../../constants.dart';

class InfoSectionWidget extends StatelessWidget {
  const InfoSectionWidget({super.key, required this.title, required this.subtitle});

  final String title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return  DecoratedBox(
      decoration:const BoxDecoration(color: emptyColor),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const  SizedBox(height: 10),
              subtitle
            ],
          ),
        ),
      ),
    );
  }
}
