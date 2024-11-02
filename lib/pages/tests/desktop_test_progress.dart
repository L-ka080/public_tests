import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/data/answer_data.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/data/result_data.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/extensions/custom_data_extensions.dart';

class DesktopTestProgress extends StatefulWidget {
  final TestData data;

  // List<Map<int, Map<int, bool>>> currentTestQuestionData = [];
  List<QuestionData> currentTestQuestionData = [];

  DesktopTestProgress({
    super.key,
    required this.data,
  });

  @override
  State<DesktopTestProgress> createState() => _DesktopTestProgressState();
}

class _DesktopTestProgressState extends State<DesktopTestProgress> {
  int currentQuestionIndex = 0;
  int questionsAmount = 0;

  CarouselSliderController carouselController = CarouselSliderController();

  // List<QuestionData> questions = [];
  List<Map<int, bool>> currentTestAnswers = [];

  List<Widget> questionCards = [];
  List<Widget> answerTiles = [];
  // Timer? testTimerTicker;
  // int testETA = 0;
  // String testTimeFormatted = "";

  @override
  void initState() {
    for (QuestionData question in widget.data.questions) {
      // widget.currentTestQuestionData.add(widget.data.questions.indexOf(question): )
      List<AnswerData> questionAnswers = [];
      for (AnswerData answer in question.answers) {
        AnswerData currentAnswer = answer;
        currentAnswer.isAnswerChecked = false;

        questionAnswers.add(currentAnswer);
      }
      // widget.currentTestQuestionData.add(questionAnswers);

      widget.currentTestQuestionData = widget.data.questions.clearAnswerState();

      // testTimer = Timer(Duration(minutes: widget.data.testSettings!.time), () {
      //   Navigator.pop(
      //     context,
      //     collectTestResults(),
      //   );
      // });
      super.initState();
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   setState(() {
  //     if (testTimerTicker != null) {
  //       testTimerTicker!.cancel();
  //     }
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.data.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 30,
            left: MediaQuery.sizeOf(context).width / 9,
            right: MediaQuery.sizeOf(context).width / 9,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    CarouselSlider(
                      disableGesture: true,
                      carouselController: carouselController,
                      options: CarouselOptions(
                          initialPage: currentQuestionIndex,
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
                              currentQuestionIndex = index;
                            });
                          }),
                      items: setUpQuestions(widget.currentTestQuestionData),
                      // items: questionCards
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            carouselController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOut);
                          },
                          heroTag: null,
                          label: const Text("Previous"),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Visibility(
                          visible: !(currentQuestionIndex == widget.data.questions.length - 1),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                                    carouselController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 350),
                                        curve: Curves.easeInOut);
                                  },
                            heroTag: null,
                            label: const Text("Next"),
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(timerTime),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width / 6,
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    collectTestResults(),
                                  );
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.save_outlined),
                                    Text("Save")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // const Text(
                          //   // getTestTime(),
                          //   "",
                          //   // testTimeFormatted,
                          //   style: const TextStyle(fontSize: 20),
                          // ),
                          Wrap(
                            children: setUpMiniButtons(
                              widget.data.questions,
                              currentQuestionIndex,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> setUpQuestions(List<QuestionData> questions) {
    List<Widget> resultList = [];

    for (QuestionData question in questions) {
      List<Widget> answerTiles = [];

      for (AnswerData answer in question.answers) {
        answerTiles.add(
          CheckboxListTile(
            title: Text(answer.answerTitle ?? "Empty answer"),
            value: answer.isAnswerChecked,
            onChanged: (value) {
              setState(() {
                print("${answer.isAnswerChecked} | $value");
                answer.isAnswerChecked = value!;
              });
            },
          ),
        );
      }

      resultList.add(Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          title: Text(
            question.questionTitle ?? "Empty question",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: ListView(
              children: answerTiles,
            ),
          ),
        ),
      ));
    }

    return resultList;
  }

  List<Widget> setUpMiniButtons(
    List<QuestionData> questions,
    int selectedIndex,
  ) {
    List<Widget> resultList = [];

    for (QuestionData question in questions) {
      int questionIndex = questions.indexOf(question);

      resultList.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 5,
          ),
          child: ChoiceChip(
            label: Text((questionIndex + 1).toString()),
            selected: currentQuestionIndex == questionIndex,
            onSelected: (value) {
              setState(() {
                currentQuestionIndex = questionIndex;
                carouselController.jumpToPage(currentQuestionIndex);
              });
            },
          ),
        ),
      );
    }

    return resultList;
  }

  int getAnsweredQuestions(List<QuestionData> questions) {
    int result = 0;

    for (QuestionData quesion in questions) {
      for (AnswerData answer in quesion.answers) {
        if (answer.isAnswerChecked) {
          result++;
          break;
        }
      }
    }

    return result;
  }

  int getCorrectAnsweredQuestions(List<QuestionData> dataQuestions,
      List<QuestionData> currentTestQuestions) {
    int result = 0;

    print("""
amount of data.questions: ${widget.data.questions.length}
amount of currentTestQuestionData: ${widget.currentTestQuestionData.length}
""");

    for (var i = 0; i < currentTestQuestions.length; i++) {
      if (dataQuestions[i].answers == currentTestQuestions[i].answers) {
        for (AnswerData answer in currentTestQuestions[i].answers) {
          if (answer.isAnswerChecked) {
            result++;
          }
        }
      }
    }

    return result;
  }

  ResultData? collectTestResults() {
    return ResultData(
        userName: context.read<UserProvider>().userName,
        testId: widget.data.testId!,
        completionTime: DateTime.now().millisecondsSinceEpoch * 1000,
        questionNumber: widget.currentTestQuestionData.length,
        completedNumber: getAnsweredQuestions(
          widget.currentTestQuestionData,
        ),
        correctAnswersNumber: getCorrectAnsweredQuestions(
          widget.data.questions,
          widget.currentTestQuestionData,
        ),
        results: widget.currentTestQuestionData);
  }

  // String getTestTime() {
  //   String result = "";
  //     if (widget.data.testSettings.isTimeLimited) {
  //       testETA = widget.data.testSettings.time * 60;

  //       testTimerTicker = Timer.periodic(
  //         const Duration(seconds: 1),
  //         (Timer timer) {
  //           // testTime =
  //           if (testETA == 0) {
  //             setState(() {
  //               testTimerTicker!.cancel();
  //             });
  //           } else {
  //             setState(() {
  //               testETA--;
  //               // testTimeFormatted = "${(testETA / 60).truncate()}:${testETA % 60}";
  //               result = "${(testETA / 60).truncate()}:${testETA % 60}";
  //             });
  //           }
  //         },
  //       );
  //     }
  //   return result;
  // }
}
