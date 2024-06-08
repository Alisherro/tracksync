import 'package:flutter/material.dart';
import 'package:tracksync/core/core.dart';
import 'package:tracksync/core/widgets/button.dart';
import 'package:tracksync/core/widgets/button_text.dart';

Future<void> showConfirmationDialog(BuildContext context,
    {required VoidCallback confirm,
    required VoidCallback deny,
    required String title}) async {
  await showDialog(
    barrierColor: Colors.black.withOpacity(0.9),
    context: context,
    builder: (context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 216, left: 20, right: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonText(
                          onPressed: confirm,
                          title: 'Yes',
                        ),
                        const SizedBox(width: 5),
                        Button(
                          color: Palette.redLatte,
                          onPressed: deny,
                          title: 'No',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      );
    },
  );
}
