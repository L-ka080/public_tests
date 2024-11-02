import 'package:flutter/material.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/widgets/Misc/test_card.dart';

class DesktopAllTestsPage extends StatefulWidget {
  // final List<TestData>? data;

  const DesktopAllTestsPage({
    // required this.data,
    super.key,
  });

  @override
  State<DesktopAllTestsPage> createState() => _DesktopAllTestsPageState();
}

class _DesktopAllTestsPageState extends State<DesktopAllTestsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List<TestData>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All tests"),
        centerTitle: true,
      ),
      body: data.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close,
                    size: 35,
                  ),
                  Text("There is no tests in the system yet. Sorry"),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                top: 15,
                left: MediaQuery.sizeOf(context).width / 4,
                right: MediaQuery.sizeOf(context).width / 4,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TestCard(data: data[index], onTestDelete: null);
              },
            ),
    );
  }
}
