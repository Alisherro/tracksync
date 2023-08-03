import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracksync/constants.dart';
import 'package:tracksync/presentation/widgets/next_button_widget.dart';

import '../widgets/pop_button_widget.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopButtonWidget(
              title: 'CREATE GROUP',
              onTap: () => context.pop(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(
                      width: (MediaQuery.sizeOf(context).width - 100) / 2,
                      child: const CircleAvatar(
                        radius: 80,
                        backgroundColor: emptyColor,
                        child: Icon(
                          Icons.image_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: (MediaQuery.sizeOf(context).width - 100) / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload group image',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Image will attract more attention',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: greyColor,
                                    fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20))),
                            child: const Text('UPLOAD'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Name',
            ),
            const SizedBox(height: 5),
            const TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: emptyColor,
                filled: true,
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            const Text(
              'Description',
            ),
            const SizedBox(height: 5),
            const TextField(
              keyboardType: TextInputType.text,
              maxLines: 5,
              decoration: InputDecoration(
                fillColor: emptyColor,
                filled: true,
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: NextButtonWidget(
                isEnable: true,
                enableCallback: () =>context.go('/groups/create/group'),
                disableCallback: () {},
                title: 'Create',
              ),
            )
          ],
        ),
      ),
    );
  }
}
