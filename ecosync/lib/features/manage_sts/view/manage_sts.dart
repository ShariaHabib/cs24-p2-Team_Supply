import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../controller/get_sts_controller.dart';
import '../widget/widgets.dart';

class ManageSTS extends StatefulWidget {
  const ManageSTS({super.key});

  @override
  State<ManageSTS> createState() => _ManageSTSState();
}

class _ManageSTSState extends State<ManageSTS> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    context.read<GetSTScontroller>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetSTScontroller ctr = context.watch<GetSTScontroller>();
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
                    return const CustomDialog();
                  });
            }),
            const SizedBox(height: kDefaultPadding),
            ctr.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : STSTableView(
                    sts: context.watch<GetSTScontroller>().data,
                  )
          ],
        ),
      ),
    );
  }
}
