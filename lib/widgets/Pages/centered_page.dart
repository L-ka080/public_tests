import 'package:flutter/material.dart';

class CenteredPage extends StatelessWidget {
  final Widget child;
  //TODO Добавить проверку на layout для мобилок

  const CenteredPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 30,
          left: MediaQuery.sizeOf(context).width / 4,
          right: MediaQuery.sizeOf(context).width / 4,
        ),
        child: child,
      ),
    );
  }
}
