import 'package:ecosync/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../common/common.dart';

class EditUser extends StatefulWidget {
  const EditUser({
    super.key,
    required this.userName,
    required this.email,
    required this.userId,
  });
  final String userId;
  final String userName;
  final String email;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    _userId.text = widget.userId;
    _userName.text = widget.userName;
    _email.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      surfaceTintColor: Colors.white,
      child: Container(
        height: 464,
        width: 560,
        padding: const EdgeInsets.all(kDefaultPadding * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Update User",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: kDefaultPadding * 2),
            DialogFormFiled(
              controller: _userId,
              prefixText: "User Id",
              hintText: "User Id",
              readOnly: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
                controller: _userName,
                prefixText: "User Name",
                hintText: "User Name"),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _email,
              prefixText: "Email",
              hintText: "Email",
              readOnly: true,
            ),
            const SizedBox(height: kDefaultPadding),
            DialogFormFiled(
              controller: _password,
              prefixText: "Password",
              hintText: "Password",
              readOnly: true,
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: CustomFilledButton(
                    onPressed: () {},
                    buttonText: "Update",
                    filledColor: Theme.of(context).colorScheme.primary,
                    buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
