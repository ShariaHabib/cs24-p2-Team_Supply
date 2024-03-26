import 'package:flutter/material.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
    required this.search,
  });

  final TextEditingController search;

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.search,
      onChanged: (value) {
        setState(() {
          isEmpty = value.isEmpty;
        });
      },
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: !isEmpty
            ? IconButton(
                onPressed: () {
                  widget.search.clear();
                  setState(() {
                    isEmpty = true;
                  });
                },
                icon: const Icon(Icons.close),
              )
            : const SizedBox(),
      ),
    );
  }
}
