import 'package:flutter/material.dart';
import 'package:public_tests/data/answer_data.dart';
// import 'package:public_tests/data/question_data.dart';

class AnswerCreator extends StatefulWidget {
  final AnswerData answerData;
  final Function deleteAnswerCallBack;

  const AnswerCreator({
    super.key,
    required this.answerData,
    required this.deleteAnswerCallBack,
  });

  @override
  State<AnswerCreator> createState() => _AnswerCreatorState();
}

class _AnswerCreatorState extends State<AnswerCreator> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          labelText: "Answer",
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onChanged: (value) {
          setState(() {
            widget.answerData.answerTitle = value;
          });
        },
      ),
      leading: Checkbox(
        value: widget.answerData.isAnswerChecked,
        onChanged: (value) {
          setState(() {
            widget.answerData.isAnswerChecked = value!;
          });
        },
      ),
      trailing: IconButton(
        onPressed: () {
          widget.deleteAnswerCallBack(widget);
        },
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}
