import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../widget/widgets.dart';

class WasteCollection extends StatefulWidget {
  const WasteCollection({super.key});

  @override
  State<WasteCollection> createState() => _WasteCollectionState();
}

class _WasteCollectionState extends State<WasteCollection> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileCard(),
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
