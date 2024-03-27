import 'package:ecosync/features/dashboard/view/dashboard.dart';
import 'package:ecosync/features/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                      onPressed: () async {
                        await context
                            .read<LoginController>()
                            .getPostData(_email.text, _password.text, context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(name: "/Page1"),
                                builder: (context) => Dashboard()));
                      },
                    ),
                    const SizedBox(height: kDefaultPadding),
                    CustomFilledButton(
                        buttonText: "Forget Password",
                        buttonTextColor:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        filledColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        onPressed: () async {})
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


// AlertDialog(
//   icon: Stack(
//     clipBehavior: Clip.none,
//     alignment: Alignment.center,
//     children: [
//       Positioned(
//         top: -10,
//         child: Image.network(
//             "https://i.imgur.com/2yaf2wb.png",
//             width: 150,
//             height: 150),
//       )
//     ],
//   ),
//   title: Text("Password reset link sent"),
  // content: Text(
  //   "Successful password reset link sent to email:\n\"blabla@gmail.com\"\nplease follow the email password reset instruction",
  //   textAlign: TextAlign.center,
  // ),
// );