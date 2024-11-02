import 'package:public_tests/data/answer_data.dart';

class QuestionData {
  String? questionTitle;
  // List<Map<String, bool>> answers = [];
  List<AnswerData> answers = [];
  int? questionIndex;

  QuestionData({
    this.questionTitle,
    // this.questionIndex = 0,
  });
}
