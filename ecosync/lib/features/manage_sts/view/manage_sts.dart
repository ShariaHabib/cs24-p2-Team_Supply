import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../widget/widgets.dart';

class ManageSTS extends StatefulWidget {
  const ManageSTS({super.key});

  @override
  State<ManageSTS> createState() => _ManageSTSState();
}

class _ManageSTSState extends State<ManageSTS> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kDefaultPadding * 2),
            const BodyTitle(),
            const SizedBox(height: kDefaultPadding * 2),
            SearchBox(search: _search),
            const SizedBox(height: kDefaultPadding),
            CustomAddButton(onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog();
                  });
            }),
            const SizedBox(height: kDefaultPadding),
            const UserTableView()
          ],
        ),
      ),
    );
  }
}
