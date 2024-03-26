import 'package:flutter/material.dart';

import '../../../common/common.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key, required this.search});
  final TextEditingController search;
  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: CustomSearchField(search: widget.search),
    );
  }
}
