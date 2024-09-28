import 'package:flutter/material.dart';

class StagedPage extends StatefulWidget {
  final int amountOfPages;
  final List<Widget> content;

  const StagedPage({
    super.key,
    required this.amountOfPages,
    required this.content
  });

  @override
  State<StagedPage> createState() => _StagedPageState();
}

class _StagedPageState extends State<StagedPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
