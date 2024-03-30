import 'dart:io';

import 'package:ecosync/features/dashboard/view/dashboard.dart';
import 'package:ecosync/features/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/auth_reset_password.dart';
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
    LoginController ctl = context.watch<LoginController>();
    return Scaffold(
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
                    ctl.loading
                        ? const CircularProgressIndicator()
                        : CustomFilledButton(
                            buttonText: "login",
                            filledColor: Theme.of(context).colorScheme.primary,
                            buttonTextColor:
                                Theme.of(context).colorScheme.onPrimary,
                            onPressed: () async {
                              await ctl.getPostData(
                                  _email.text, _password.text, context);

                              if (!ctl.loading &&
                                  ctl.success &&
                                  context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // settings: RouteSettings(name: "/Page1"),
                                    builder: (context) => Dashboard(
                                        roleId: ctl.data.userInfo.role_id,
                                        userName: ctl.data.userInfo.user_name),
                                  ),
                                );
                              } else {
                                customResponseDialog(context, "Login Failed",
                                    "User ID or Password is incorrect",
                                    isError: true);
                              }
                            },
                          ),
                    const SizedBox(height: kDefaultPadding),
                    CustomFilledButton(
                      buttonText: "Forget Password",
                      buttonTextColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      filledColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const PasswordReset();
                            });
                      },
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

class PasswordReset extends StatefulWidget {
  const PasswordReset({
    super.key,
  });

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _token = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !isPressed
                ? SizedBox(
                    width: 300,
                    child: AuthTextField(
                        hintText: "Email",
                        labelText: "Email",
                        prefixIcon: Icons.email,
                        controller: _email))
                : Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: AuthTextField(
                              hintText: "Reset Token",
                              labelText: "Reset Token",
                              prefixIcon: Icons.token,
                              controller: _token)),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      SizedBox(
                          width: 300,
                          child: AuthTextField(
                              hintText: "New Password",
                              labelText: "New Password",
                              prefixIcon: Icons.lock,
                              controller: _newPassword)),
                    ],
                  ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            FilledButton(
                onPressed: () async {
                  if (!isPressed) {
                    await ResetPasswordInitiate.reset(_email.text);
                    setState(() {
                      isPressed = true;
                    });
                  } else {
                    await ResetPasswordConfirm.confirm(
                        _token.text, _newPassword.text);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: const Text("OK"))
          ],
        ),
      ),
    );
  }
}
