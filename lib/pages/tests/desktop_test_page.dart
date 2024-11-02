import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/data/provider/test_provider.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/data/result_data.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/pages/tests/desktop_test_progress.dart';
import 'package:public_tests/widgets/Misc/result_card.dart';
import 'package:public_tests/widgets/Pages/centered_page.dart';

import 'dart:html' as html;

class DesktopTestPage extends StatefulWidget {
  final TestData data;

  const DesktopTestPage({
    super.key,
    required this.data,
  });

  @override
  State<DesktopTestPage> createState() => _DesktopTestPageState();
}

class _DesktopTestPageState extends State<DesktopTestPage> {
  @override
  //TODO Скопировать лейаут с new_test, но убрать интерактивные элементы с него
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
        centerTitle: true,
      ),
      body: CenteredPage(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: widget.data.results.length,
                    itemBuilder: (context, index) {
                      return ResultCard(resultData: widget.data.results[index]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 70,
                  child: OutlinedButton(
                    onPressed: () async {
                      ResultData? testResult = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DesktopTestProgress(data: widget.data),
                        ),
                      );
                      if (testResult != null) {
//                         print("""
// userName: ${testResult.userName}
// completionTime: ${testResult.completionTime}
// questionNumber: ${testResult.questionNumber}
// completedNumber: ${testResult.completedNumber}
// correctAnswersNumber: ${testResult.correctAnswersNumber}""");
                        print(testResult.toJson());

                        if (context.mounted) {
                          ApiHandler.createNewResult(
                              widget.data.testId!,
                              testResult,
                              context.read<UserProvider>().userToken);

                              setState(() {
                                widget.data.results.add(testResult);
                              });
                        }
                      } else {
                        print("null");
                      }

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Start this test"),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  // List<Widget> getAnswersData(QuestionData question) {
  //   List<Widget> resultList = [];

  //   for (AnswerData answer in question.answers) {
  //     resultList.add(Text("${answer.answerTitle}: ${answer.isAnswerChecked}"));
  //   }

  //   return resultList;
  // }

  List<Widget> getResultsData() {
    List<Widget> resultList = [];

    if (widget.data.results != null) {
      for (ResultData result in widget.data.results!) {
        resultList.add(ListTile(title: Text(result.toString())));
      }
    }
    return resultList;
  }
}
