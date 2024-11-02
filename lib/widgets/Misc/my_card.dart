import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String? title;
  final Widget? contents;
  final int sizeDeminisher;
  final Icon? avatar;
  const MyCard({
    required this.title,
    required this.contents,
    required this.sizeDeminisher,
    this.avatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / sizeDeminisher,
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(title ?? "Untitled"),
          ),
          trailing: avatar,
          subtitle: contents,
        ),
      ),
    );
  }
}
