import 'package:public_tests/data/test_data.dart';

class UserData {
  String name;
  String surname;
  List<TestData>? tests;

  UserData({required this.name, required this.surname, this.tests});
}
