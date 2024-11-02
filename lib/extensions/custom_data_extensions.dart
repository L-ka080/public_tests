import 'dart:convert';

import 'package:public_tests/data/answer_data.dart';
import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/data/test_settings_data.dart';

extension JsonifyQuestionDataList on List<QuestionData> {
  String toJsonString() {
    List<Map<String, dynamic>> resultList = [];

    for (QuestionData question in this) {
      List<AnswerData> answers = question.answers;

      List<Map<String, dynamic>> answersList = [];

      for (var answer in answers) {
        Map<String, dynamic> answerMap = {
          "answerTitle": answer.answerTitle,
          "isAnswerChecked": answer.isAnswerChecked
        };

        answersList.add(answerMap);
      }

      Map<String, dynamic> questionMap = {
        "questionTitle": question.questionTitle,
        "answers": answersList
      };

      resultList.add(questionMap);
    }

    return jsonEncode(resultList);
  }
}

extension JsonifyTestSettings on TestSettingsData {
  String toJsonString() {
    // return """$testID;$isTimeLimited;$time;'$testType';$toShowCorrectAnswersAfter;$toShuffleQuestions;$toShuffleAnswers;$toShowShowAnswersNumber;""";
    return '''{"testType": "$testType", "time": $time, "isTimeLimited": $isTimeLimited, "toShowCorrectAnswersAfter": $toShowCorrectAnswersAfter, "toShuffleQuestions": $toShuffleQuestions, "toShuffleAnswers": $toShuffleAnswers, "toShowShowAnswersNumber": $toShowShowAnswersNumber}''';
  }
}

extension RecieveQuestionData on List<dynamic> {
  List<QuestionData> fromJsonQuestions() {
    List<QuestionData> resultQuestions = [];

    for (Map<String, dynamic> data in this) {
      QuestionData question = QuestionData();

      question.questionTitle = data["questionTitle"];
      List<AnswerData> answers = [];
      List<dynamic> answersJson = data["answers"];

      for (Map<String, dynamic> answerData in answersJson) {
        AnswerData collectedAnswer = AnswerData(
          answerTitle: answerData["answerTitle"],
          isAnswerChecked: answerData["isAnswerChecked"],
        );

        answers.add(collectedAnswer);
      }

      question.answers = answers;

      resultQuestions.add(question);
    }

    return resultQuestions;
  }
}

extension ClearAnswersInQuestions on List<QuestionData> {
  List<QuestionData> clearAnswerState() {
    List<QuestionData> resultQuestions = [];
    resultQuestions.addAll(this);

    for (QuestionData question in resultQuestions) {
      for (AnswerData answer in question.answers) {
        answer.isAnswerChecked = false;
      }
    }

    return resultQuestions;
  }

  List<QuestionData> shuffleQuestions() {
    List<QuestionData> resultQuestions = [];

    // TODO Реализовать функцию
    return resultQuestions;
  }

  List<QuestionData> shuffleAnswers() {
    List<QuestionData> resultQuestions = [];

    // TODO Реализовать функцию
    return resultQuestions;
  }
}
