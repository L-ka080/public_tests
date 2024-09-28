import 'package:flutter/material.dart';
import 'package:public_tests/data/answer_data.dart';
import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/widgets/answer_creator.dart';

class QuestionCreator extends StatefulWidget {
  // TextEditingController questionTitleContoller = TextEditingController();
  final QuestionData questionData;
  final Function deleteThisQuestionCallback;
  TextEditingController questionTitleController = TextEditingController();

  QuestionCreator({
    super.key,
    required this.questionData,
    required this.deleteThisQuestionCallback,
  });

  @override
  State<QuestionCreator> createState() => _QuestionCreatorState();
}

//TODO Сделать проверку на количество ответов или сделать автоматическое добавление/удаление двух ответов, если там их нет
//TODO Надо сделать удаление вопросов и ответов в вопросах

class _QuestionCreatorState extends State<QuestionCreator>
    with AutomaticKeepAliveClientMixin {
  List<AnswerCreator> answerCreators = [];

  @override
  void initState() {
      createAnswerCreator(amount: 2);

    // widget.questionTitleController.text = widget.questionData.questionTitle ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Text(
                "${widget.questionData.questionIndex + 1}",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              title: TextField(
                controller: widget.questionTitleController,
                decoration: InputDecoration(
                  labelText: "Question Title",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.questionData.questionTitle = value;
                  });
                },
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    widget.deleteThisQuestionCallback(widget);
                  });
                },
                icon: const Icon(Icons.delete_outline),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    if (answerCreators.length < 10) {
                      createAnswerCreator(amount: 1);
                    }
                  });
                },
                child: const Text("New Answer"),
              ),
            ),
            SizedBox(
              height: 65 * answerCreators.length.toDouble(),
              width: MediaQuery.sizeOf(context).width,
              child: ListView(
                shrinkWrap: false,
                children: answerCreators,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void createAnswerCreator({int amount = 1}) {
    if (amount <= 0) amount = 1;

    for (var i = 0; i < amount; i++) {
      AnswerData answerData = AnswerData();
      // questionDataInstance.answers.add(answerData);
      widget.questionData.answers.add(answerData);
      AnswerCreator answerCreator = AnswerCreator(
        answerData: answerData,
        deleteAnswerCallBack: () {},
      );
      answerCreators.add(answerCreator);
    }
  }

  void deleteThisAnswerCreator(AnswerCreator instance) {
    setState(() {
      print(widget.questionData.answers.remove(instance.answerData));
      print(answerCreators.remove(instance));
      // if (answerCreators.length < 2) {
      //   createAnswerCreator(amount: 1);
      // }
    });
  }
}
