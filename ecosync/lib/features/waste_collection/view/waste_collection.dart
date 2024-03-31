import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../controller/waste_collection_controller.dart';
import '../widget/widgets.dart';

class WasteCollection extends StatefulWidget {
  const WasteCollection({super.key, required this.userName});
  final String userName;

  @override
  State<WasteCollection> createState() => _WasteCollectionState();
}

class _WasteCollectionState extends State<WasteCollection> {
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    context.read<WasteCollectionController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WasteCollectionController ctr = context.watch<WasteCollectionController>();
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
            ctr.loading
                ? const Center(child: CircularProgressIndicator())
                : UserTableView(
                    search: _search,
                    wasteCollection: ctr.data,
                  )
          ],
        ),
      ),
    );
  }
}
