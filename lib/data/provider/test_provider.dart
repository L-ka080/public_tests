import 'package:flutter/material.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/data/test_data.dart';

class TestProvider extends ChangeNotifier {
  List<TestData>? testData;
  int createdOn;
  bool? hasData;

  TestProvider({
    this.testData,
    this.createdOn = 0,
  });

  void fetchUserTests(String userToken) async {
    testData = null;

    testData = await ApiHandler.getUserTests(userToken);

    notifyListeners();
  }

  // void addNewTestDEV(TestData? data) async {
  //   if (data == null) {
  //     return;
  //   }

  //   if (testData != null) {
  //     testData!.add(data);
  //     notifyListeners();
  //   } else {
  //     return;
  //   }
  // }
}
