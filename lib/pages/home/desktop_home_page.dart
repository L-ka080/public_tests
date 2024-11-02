import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/data/provider/prefs_provider.dart';
import 'package:public_tests/data/provider/test_provider.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/widgets/Misc/test_card.dart';

import 'package:public_tests/constants/routes.dart';

class DesktopHomePage extends StatefulWidget {
  // final SharedPreferences preferences;
  // UserLoginDTOCreds? userCreds;

  const DesktopHomePage({
    super.key,
    // required this.preferences,
  });
  // userCreds = UserLoginDTOCreds.fromJSON(
  // jsonDecode(preferences.getString("userCreds") ?? "{}"));

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

int pageSelectedIndex = 0;
bool railExpanded = false;
bool isLoggedIn = false;

class _DesktopHomePageState extends State<DesktopHomePage> {
  @override
  void initState() {
    super.initState();

    String userCredsJson =
        context.read<PrefsProvider>().preferences.getString("userCreds") ??
            "{}";
    UserLoginCredsDTO userCreds =
        UserLoginCredsDTO.fromJSON(jsonDecode(userCredsJson));

    print(
        "${userCreds.userName} | ${userCreds.isLoggedIn} | ${userCreds.token}");

    if (userCreds.isLoggedIn) {
      isLoggedIn = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (time) {
          context.read<UserProvider>().addLoginData(
                userName: userCreds.userName ?? "",
                userToken: userCreds.token ?? "",
              );
        },
      );
      context.read<TestProvider>().fetchUserTests(userCreds.token!);
    } else {
      WidgetsBinding.instance.addPostFrameCallback(
        (time) {
          Navigator.pushNamed(context, Routes.logInRoute);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TestData> loadedTests = context.watch<TestProvider>().testData ?? [];

    if (isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Welcome back, ${context.read<UserProvider>().userName}"),
          leading: IconButton(
            onPressed: () {
              context.read<PrefsProvider>().preferences.clear().then((state) {
                if (context.mounted && state) {
                  Navigator.pushReplacementNamed(context, Routes.logInRoute);
                }
              });
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
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        List<TestData> allTests = await ApiHandler.getAllTests();

                        if (context.mounted) {
                          Navigator.pushNamed(context, Routes.allTestsPage, arguments: allTests);
                        }
                      },
                      tooltip: "See all tests",
                      icon: const Icon(Icons.search_rounded),
                    ),
                    const Text("Your Tests", style: TextStyle(fontSize: 26)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: MediaQuery.sizeOf(context).width / 4,
                    right: MediaQuery.sizeOf(context).width / 4,
                  ),
                  itemCount: loadedTests.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox(
                        height: 70,
                        width: MediaQuery.sizeOf(context).width,
                        child: OutlinedButton(
                          onPressed: () async {
                            TestData? newTest = await Navigator.pushNamed(
                                context, Routes.newTest) as TestData?;
                            if (context.mounted) {
                              if (newTest != null) {
                                setState(() {
                                  Provider.of<TestProvider>(context,
                                          listen: false)
                                      .testData!
                                      .add(newTest);
                                });
                              }
                            }
                          },
                          child: const Text("+ New Test"),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TestCard(
                          data: loadedTests[index - 1],
                          onTestDelete: () {
                            TestData selectedTest = loadedTests[index - 1];
                            ApiHandler.deleteSelectedTest(selectedTest.testId);

                            setState(() {
                              Provider.of<TestProvider>(context, listen: false)
                                  .testData!
                                  .remove(selectedTest);
                            });

                            SnackBar message = SnackBar(
                              content: Text(
                                  "Test '${selectedTest.title}' has been deleted"),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(message);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text("YOU'RE FOOL"),
        ),
      );
    }
  }
}
