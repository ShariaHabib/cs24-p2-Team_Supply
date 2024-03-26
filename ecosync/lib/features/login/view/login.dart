import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 400,
            width: 450,
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding * 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthTextField(
                      controller: _email,
                      hintText: "Email",
                      labelText: "Email",
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    AuthTextField(
                      controller: _password,
                      hintText: "Password",
                      labelText: "Password",
                      prefixIcon: Icons.lock_outlined,
                      isSecured: true,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    CustomFilledButton(
                      buttonText: "login",
                      filledColor: Theme.of(context).colorScheme.primary,
                      buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () {},
                    ),
                    const SizedBox(height: kDefaultPadding),
                    CustomFilledButton(
                      buttonText: "Forget Password",
                      buttonTextColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      filledColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
