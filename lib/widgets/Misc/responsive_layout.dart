import 'package:flutter/material.dart';
import 'package:public_tests/constants/screen_sizes.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;

  const ResponsiveLayout({
    super.key,
    required this.desktop,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= minDesktopWidth) {
            return mobile;
          } else {
            return desktop;
          }
        },
      ),
    );
  }
}
