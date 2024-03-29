import 'package:ecosync/common/common.dart';
import 'package:ecosync/common/custom_filled_button.dart';
import 'package:ecosync/features/profile/widget/custom_text_field_prefix.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../manage_users/controller/update_user_controller.dart';
import '../../manage_users/widget/custom_popup.dart';
import '../controller/get_user_profile_controller.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _role = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserProfileController>().getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileController>(
      builder: (context, userProfileController, _) {
        if (userProfileController.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final userData = userProfileController.data.userData;
          _email.text = userData['email'] ?? '';
          _userId.text = userData['user_id'] ?? '';
          _userName.text = userData['user_name'] ?? '';
          _role.text = userData['user_role'] ?? '';

          UpdateUsersController ctrRegist =
              context.watch<UpdateUsersController>();
          return Scaffold(
            body: Center(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                height: 700,
                width: 500,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding * 2),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 100,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(height: 50),
                        CustomTextFieldPrefix(
                          controller: _email,
                          readOnly: true,
                          prefixText: "Email",
                        ),
                        const SizedBox(height: kDefaultPadding * 2),
                        CustomTextFieldPrefix(
                          controller: _userId,
                          readOnly: true,
                          prefixText: "User Id",
                        ),
                        const SizedBox(height: kDefaultPadding * 2),
                        CustomTextFieldPrefix(
                          controller: _userName,
                          readOnly: false,
                          prefixText: "User Name",
                        ),
                        const SizedBox(height: kDefaultPadding * 2),
                        CustomTextFieldPrefix(
                          controller: _role,
                          readOnly: true,
                          prefixText: "Assigned Role",
                        ),
                        const SizedBox(height: kDefaultPadding * 3),
                        CustomFilledButton(
                          buttonTextColor: Colors.white,
                          filledColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            await context
                                .read<UpdateUsersController>()
                                .updateData(
                                    context, _userName.text, _userId.text);
                            if (!ctrRegist.loading && context.mounted) {
                              customResponseDialog(
                                  context, "Update Successful", "",
                                  isProfile: true);
                            }
                          },
                          buttonText: "Update",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
