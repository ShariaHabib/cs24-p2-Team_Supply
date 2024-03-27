import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class PermissionCheckBox extends StatefulWidget {
  const PermissionCheckBox({super.key});

  @override
  State<PermissionCheckBox> createState() => _PermissionCheckBoxState();
}

class _PermissionCheckBoxState extends State<PermissionCheckBox> {
  List<bool> isChecked = List.generate(15, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 250),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 4,
            crossAxisSpacing: 15,
            mainAxisSpacing: 5,
          ),
          itemCount: isChecked.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Checkbox(
                  value: isChecked[index],
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked[index] = value!;
                    });
                  },
                ),
                Text('Item ${index + 1}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
