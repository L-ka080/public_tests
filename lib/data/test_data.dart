import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/data/test_settings_data.dart';

class TestData {
  String? title;
  List<QuestionData> questions;
  TestSettingsData testSettings;

  TestData({required this.title, required this.questions, required this.testSettings});
}
