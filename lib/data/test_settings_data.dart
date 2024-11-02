class TestSettingsData {
  bool isTimeLimited = false;
  int time = 0;
  String testType = "Survey";
  bool toShowCorrectAnswersAfter = false;
  bool toShuffleQuestions = false;
  bool toShuffleAnswers = false;
  bool toShowShowAnswersNumber = false;

  TestSettingsData.fromJsonString(Map<String, dynamic> testSettingsEntry) {
    isTimeLimited = testSettingsEntry["isTimeLimited"] ?? false;
    time = testSettingsEntry["time"] ?? 0;
    testType = testSettingsEntry["testType"] ?? false;
    toShowCorrectAnswersAfter = testSettingsEntry["toShowCorrectAnswersAfter"] ?? false;
    toShuffleQuestions = testSettingsEntry["toShuffleQuestions"] ?? false;
    toShuffleAnswers = testSettingsEntry["toShuffleAnswers"] ?? false;
    toShowShowAnswersNumber = testSettingsEntry["toShowShowAnswersNumber"] ?? false;
  }

  TestSettingsData();
}
