import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter app"),
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      ),
      body: const Center(
        child: Text("Hello world"),
      ),
    );
  }
}
