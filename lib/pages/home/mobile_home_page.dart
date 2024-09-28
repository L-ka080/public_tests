import 'package:flutter/material.dart';
import 'package:public_tests/pages/home/desktop_home_page.dart';
import 'package:public_tests/widgets/add_test_action_button.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter web for mobile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      ),
      body: const Text("Something for mobile"),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: pageSelectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            pageSelectedIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
      floatingActionButton: const AddTestActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
