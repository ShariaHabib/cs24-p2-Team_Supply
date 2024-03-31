import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../controller/get_waste_dispose_controller.dart';
import '../widget/widgets.dart';

class WasteDispose extends StatefulWidget {
  const WasteDispose({super.key, required this.userName});
  final String userName;

  @override
  State<WasteDispose> createState() => _WasteDisposeState();
}

class _WasteDisposeState extends State<WasteDispose> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    context.read<GetWaasteDisposeController>().getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetWaasteDisposeController ctr =
        context.watch<GetWaasteDisposeController>();
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
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : WasteDisposeTable(
                    search: _search,
                    wasteDispose: ctr.data,
                  )
          ],
        ),
      ),
    );
  }
}
