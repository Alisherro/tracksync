import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../constants.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Register', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              'Create your new account',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Full Name',
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const SizedBox(width: 5),
                    Text(
                      'Remember Me',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                Text(
                  'Forgot Password ?',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Text('Or continue with'),
                SizedBox(width: 10),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                            backgroundColor:
                                const MaterialStatePropertyAll(pinkColor)),
                    onPressed: () {},
                    child: Text('Google'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                          backgroundColor:
                              const MaterialStatePropertyAll(blueColor),
                          padding:
                              const MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/apple_logo.svg'),
                        const SizedBox(width: 12),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text('Apple'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?  ',
                  style: TextStyle(color: greyColor),
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/');
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: secondColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
