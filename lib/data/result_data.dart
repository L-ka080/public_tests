import 'dart:convert';

import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/extensions/custom_data_extensions.dart';

class ResultData {
  String userName;
  int testId;

  int completionTime;
  int questionNumber;
  int completedNumber;
  int correctAnswersNumber;
  List<QuestionData> results;

  ResultData({
    required this.userName,
    required this.testId,
    required this.completionTime,
    required this.questionNumber,
    required this.completedNumber,
    required this.correctAnswersNumber,
    required this.results,
  });

  String toJson() {
    return """
{
  "userName": "$userName",
  "testId": $testId,
  "resultData": 
  '{
    "completionTime": $completionTime,
    "questionNumber": $questionNumber,
    "completedNumber": $completedNumber,
    "correctAnswersNumber": $correctAnswersNumber,
    "results": ${results.toJsonString()}
  }'
}""";
  }
  static ResultData fromJsonString(Map<String, dynamic> resultDataEntry) {
    Map<String, dynamic> resultData = jsonDecode(resultDataEntry["resultData"]);

    List<dynamic> resultsList = resultData["results"];

    ResultData newResultData = ResultData(
      userName: resultDataEntry["userName"] ?? "",
      testId: resultDataEntry["testID"] ?? 0,
      completionTime: resultData["completionTime"],
      questionNumber: resultData["questionNumber"],
      completedNumber: resultData["completedNumber"],
      correctAnswersNumber: resultData["correctAnswersNumber"],
      results: resultsList.fromJsonQuestions(),
    );

    return newResultData;
  }
}
