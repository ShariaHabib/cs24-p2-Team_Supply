import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../controller/user_controller.dart';
import '../widget/widgets.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key, required this.userName});
  final String userName;

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    context.read<GetUsersController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetUsersController ctr = context.watch<GetUsersController>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(userName: widget.userName),
            const BodyTitle(),
            const SizedBox(height: kDefaultPadding * 2),
            SearchBox(search: _search),
            const SizedBox(height: kDefaultPadding),
            CustomAddButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const CustomDialog();
                  });
            }),
            const SizedBox(height: kDefaultPadding),
            ctr.loading
                ? const Center(child: CircularProgressIndicator())
                : UserTableView(
                    users: context.watch<GetUsersController>().data,
                    search: _search,
                  ),
          ],
        ),
      ),
    );
  }
}
