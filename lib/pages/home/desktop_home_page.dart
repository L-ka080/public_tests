import 'package:flutter/material.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/data/test_settings_data.dart';
import 'package:public_tests/pages/new_test/desktop_new_test.dart';
import 'package:public_tests/widgets/test_card.dart';
import 'package:http/http.dart' as http;

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

int pageSelectedIndex = 0;
bool railExpanded = false;

class _DesktopHomePageState extends State<DesktopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome back, John Doe."),
        leading: IconButton(
          onPressed: () async {
            // print(testWebConnection());
            http.Response response = await testWebConnection();
            print(response.body);
          },
          tooltip: "Log out",
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width / 4,
                  top: 30,
                  bottom: 15),
              child: const Text("Your Tests", style: TextStyle(fontSize: 26)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: 15,
                  left: MediaQuery.sizeOf(context).width / 4,
                  right: MediaQuery.sizeOf(context).width / 4,
                ),
                itemCount: 10 + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SizedBox(
                      height: 70,
                      width: MediaQuery.sizeOf(context).width,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const DesktopNewTest();
                              },
                            ),
                          );
                        },
                        child: const Text("+ New Test"),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TestCard(
                        data: TestData(
                            title: "PLACEHOLDER",
                            questions: [],
                            testSettings: TestSettingsData()
                            // amountOfQuestions: 13,
                            ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 15),
      //   child: FloatingActionButton.extended(
      //     onPressed: () {},
      //     label: const Text(
      //       "New Test",
      //       style: TextStyle(fontSize: 16),
      //     ),
      //     icon: const Icon(Icons.add),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  Future<http.Response> testWebConnection() {
    return http.get(Uri(host: "localhost", port: 5050));
    // return http.put(Uri(host: "127.0.0.1", port: 5050));
  }
}
