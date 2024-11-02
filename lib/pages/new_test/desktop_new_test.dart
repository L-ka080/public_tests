import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/constants/const_texts.dart';
import 'package:public_tests/data/answer_data.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/data/test_settings_data.dart';
import 'package:public_tests/widgets/Pages/centered_page.dart';
import 'package:public_tests/widgets/Tests/question_creator.dart';
import 'package:public_tests/widgets/Tests/test_settings.dart';

import '../../data/question_data.dart';

class DesktopNewTest extends StatefulWidget {
  const DesktopNewTest({super.key});

  @override
  State<DesktopNewTest> createState() => _DesktopNewTestState();
}

class _DesktopNewTestState extends State<DesktopNewTest> {
  String newTestTitle = "";

  Set<String> selectedTestType = {"Survey"};
  List<String> testTypes = ["Survey", "Quiz"];

  int selectedTypeIndex = 0;
  int currentPageIndex = 0;

  TextEditingController titleController = TextEditingController();
  CarouselSliderController carouselController = CarouselSliderController();
  TestSettingsData testSettingsData = TestSettingsData();

  List<QuestionCreator> questionsWidgets = [];
  List<QuestionData> questions = [];
  ScrollController questionsScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isTextEmpty(newTestTitle) ? "New Test" : newTestTitle),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CarouselSlider(
            disableGesture: true,
            carouselController: carouselController,
            options: CarouselOptions(
                initialPage: currentPageIndex,
                height: MediaQuery.sizeOf(context).height - 150,
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
                disableCenter: true,
                pageSnapping: false,
                scrollDirection: Axis.horizontal,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPageIndex = index;
                  });
                }),
            items: [
              // 1 PAGE
              CenteredPage(
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          autofocus: true,
                          controller: titleController,
                          style: const TextStyle(fontSize: 22),
                          decoration: InputDecoration(
                            hintText: "Test Title",
                            hintStyle: const TextStyle(fontSize: 22),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              newTestTitle = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SegmentedButton(
                          segments: const [
                            ButtonSegment(
                                value: "Survey", label: Text("Survey")),
                            ButtonSegment(value: "Quiz", label: Text("Quiz")),
                          ],
                          selected: selectedTestType,
                          onSelectionChanged: (value) {
                            setState(() {
                              testSettingsData.testType = value.first;
                              selectedTestType = value;
                              // selectedTypeIndex = setSetValueToIndex(
                              // selectedTestType, testTypes);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 65),
                        child: RichText(
                          text: TextSpan(
                              text: selectedTestType.contains("Survey") ? ConstTexts.SurveyDescription : ConstTexts.QuizDescription
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // 2 PAGE
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: MediaQuery.sizeOf(context).width / 6,
                    right: MediaQuery.sizeOf(context).width / 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: questionsWidgets.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.question_answer_outlined,
                                      size: 35,
                                    ),
                                    Text("Here your questions go!")
                                  ],
                                ),
                              )
                            : ListView.builder(
                                controller: questionsScrollController,
                                itemCount: questionsWidgets.length,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: questionsWidgets[index],
                                  );
                                },
                              ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              Visibility(
                                visible: selectedTestType.first != testTypes[0],
                                child: TestSettingsBuilder(
                                  testSettingsData: testSettingsData,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: SizedBox(
                                  height: 60,
                                  width: MediaQuery.sizeOf(context).width,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        QuestionData questionData =
                                            QuestionData();
                                        questions.add(questionData);

                                        questionData.questionIndex =
                                            questions.indexOf(questionData);

                                        questionsWidgets.add(QuestionCreator(
                                          questionData: questionData,
                                          deleteThisQuestionCallback:
                                              deleteThisQuestion,
                                        ));
                                      });
                                    },
                                    child: const Text("+ New Question"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          CenteredPage(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: currentPageIndex != 0,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      carouselController.previousPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut);
                    },
                    heroTag: null,
                    label: const Text("Previous"),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                Visibility(
                  visible: !isTextEmpty(newTestTitle),
                  child: currentPageIndex == 0
                      ? FloatingActionButton.extended(
                          onPressed: () {
                            setState(() {
                              carouselController.nextPage(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeInOut);
                            });
                          },
                          heroTag: null,
                          label: const Text("Next"),
                          icon: const Icon(Icons.arrow_forward),
                        )
                      : FloatingActionButton.extended(
                          onPressed: () async {
                            TestData testData = TestData(
                                title: newTestTitle,
                                testId: null,
                                testSettings: testSettingsData,
                                results: [],
                                createdOn:
                                    DateTime.now().millisecondsSinceEpoch *
                                        1000);

                            testData.questions = questions;

//                             print(testData.title);

//                             for (var question in testData.questions) {
//                               print("Q: ${question.questionTitle}");
//                               for (var answer in question.answers) {
//                                 print(
//                                     "A: ${answer.answerTitle}: ${answer.isAnswerChecked}");
//                               }
//                             }

//                             print("""
// Test type: ${testData.testSettings.testType}
// Time: ${testData.testSettings.isTimeLimited}: ${testData.testSettings.time}
// Correct answers after: ${testData.testSettings.toShowCorrectAnswersAfter}
// Shuffle questtions: ${testData.testSettings.toShuffleQuestions}
// "Shuffle answers: ${testData.testSettings.toShuffleAnswers}""");

                            MapEntry<String, bool> testState =
                                verifyTestContents(testData);
                            
                            SnackBar message = SnackBar(
                              content: Text(testState.key),
                            );
                            
                            ScaffoldMessenger.of(context).showSnackBar(message);
                            
                            if (testState.value) {
                              String currentUserToken =
                                  context.read<UserProvider>().userToken;

                              testData.testId = await ApiHandler.createNewTest(
                                  testData, currentUserToken);

                              if (context.mounted) {
                                Navigator.pop(context, testData);
                              }
                            }
                          },
                          heroTag: null,
                          label: const Text("Save"),
                          icon: const Icon(Icons.save_outlined),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isTextEmpty(String? title) {
    if (title == null || title == "") {
      return true;
    } else {
      return false;
    }
  }

  int setSetValueToIndex(Set<String> targetSet, List<String> allValues) {
    return allValues.indexOf(targetSet.toList()[0]);
  }

  String getShortQuestionTitle(String title) {
    int startIndex = 0;
    int indexOfSpace = 0;

    for (int i = 0; i < 6; i++) {
      indexOfSpace = title.indexOf(' ', startIndex);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return title;
      }
      startIndex = indexOfSpace + 1;
    }

    return '${title.substring(0, indexOfSpace)}...';
  }

  void deleteThisQuestion(QuestionCreator questionCreator) {
    setState(() {
      print(
          "${questionsWidgets.indexOf(questionCreator)} / ${questions.indexOf(questionCreator.questionData)} (${questionCreator.questionData.questionTitle})");
      print(questions.remove(questionCreator.questionData));
      print(questionsWidgets.remove(questionCreator));

      updateQuestions();
    });
  }

  void updateQuestions() {
    setState(() {
      for (QuestionCreator questionCreator in questionsWidgets) {
        questionCreator.questionData.questionIndex =
            questionsWidgets.indexOf(questionCreator);
        questionCreator.questionTitleController.text =
            questions[questions.indexOf(questionCreator.questionData)]
                    .questionTitle ??
                "";
        // questionCreator.questionData.questionTitle = questions[questions.indexOf(questionCreator.questionData)].questionTitle;
        // questionCreator.createState();
      }
    });
  }

  MapEntry<String, bool> verifyTestContents(TestData data) {
    if (data.questions.isEmpty) {
      return const MapEntry("The test must have at least one question", false);
    }

    for (QuestionData question in data.questions) {
      int counter = 0;

      for (AnswerData answer in question.answers) {
        if (answer.isAnswerChecked) {
          counter += 1;
        }
      }

      if (counter == 0) {
        return const MapEntry("At least one answer must be checked", false);
      }
    }

    return MapEntry("Test '${data.title}' has been created", true);
  }
}
