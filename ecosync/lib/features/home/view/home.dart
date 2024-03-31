import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/profile_card.dart';
import '../../../constants/constants.dart';
import '../../dashboard/map_view.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.userName});
  final String userName;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // const FlutterSecureStorage().deleteAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileCard(userName: widget.userName),
            const SizedBox(
              height: 50,
            ),
            Container(height: 500, width: 500, child: MapScreen()),
          ],
        ),
      ),
    );
  }
}
