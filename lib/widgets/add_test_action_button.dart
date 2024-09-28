import 'package:flutter/material.dart';

class AddTestActionButton extends StatefulWidget {
  const AddTestActionButton({super.key});
  // AddTestActionButton({Key? key, required this.expanded}) : super(key: key);

  @override
  State<AddTestActionButton> createState() => _AddTestActionButtonState();
}

class _AddTestActionButtonState extends State<AddTestActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }
}
