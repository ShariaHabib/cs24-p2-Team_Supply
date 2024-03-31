import 'package:ecosync/features/billings/controller/get_bills_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../../manage_users/widget/custom_popup.dart';
import '../../manage_users/widget/searchbox.dart';
import '../../manage_users/widget/title.dart';
import '../widget/table.dart';

class Billings extends StatefulWidget {
  const Billings({super.key, required this.userName});
  final String userName;

  @override
  State<Billings> createState() => _BillingsState();
}

class _BillingsState extends State<Billings> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    context.read<GetBillsController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    return CustomDialog();
                  });
            }),
            const SizedBox(height: kDefaultPadding),
            BillingsTable(
              billings: context.watch<GetBillsController>().data,
            )
          ],
        ),
      ),
    );
  }
}
