
import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/data/result_data.dart';
import 'package:public_tests/data/test_settings_data.dart';
import 'package:public_tests/extensions/custom_data_extensions.dart';

class TestData {
  String title;
  int? testId;
  List<QuestionData> questions = [];
  TestSettingsData testSettings;
  int createdOn;
  List<ResultData> results;

  TestData({
    required this.testId,
    required this.title,
    // this.questions,
    required this.testSettings,
    required this.createdOn,
    required this.results,
  });

  static TestData fromJSON(Map<String, dynamic> json) {
    // TestSettingsData testSettings = TestSettingsData();
    // QuestionData questionData = QuestionData();

    TestSettingsData testSettings = json["testSettings"] ?? TestSettingsData();
    // TODO Проверить работоспособность создания списка прямо в конструкторе
    QuestionData questionData = json["questionData"] ?? QuestionData();

    TestData data = TestData(
      title: json["title"] ?? "Unnamed Test",
      testId: json["id"],
      createdOn: json["createdOn"] ?? 0,
      results: [],
      testSettings: testSettings,
    );
    data.questions = [questionData];

    return data;
  }

  String toJson() {
    // "testSettings": ${testSettings != null ? testSettings!.toJson() : ""}
    // "questionData": ${questions != null ? questions!.toJson() : ""}
    return """
{
  "title": "$title",
  "testSettings": '${testSettings.toJsonString()}',
  "questionData": '${questions.toJsonString()}',
}
""";

    // return {
    //   "title": title,
    //   // "testSettings": jsonEncode(testSettings),
    //   // "testSettings": testSettings != null ? testSettings!.toJson() : "",
    //   "testSettings": testSettings != null ? testSettings!.toJson() : "",
    //   "questionData": questions != null ? questions!.toJson() : ""
    // };
  }
}
