import 'package:flutter/material.dart';
import 'package:public_tests/data/test_settings_data.dart';

class TestSettingsBuilder extends StatefulWidget {
  final TestSettingsData testSettingsData;
  const TestSettingsBuilder({
    super.key,
    required this.testSettingsData,
  });

  @override
  State<TestSettingsBuilder> createState() => _TestSettingsBuilderState();
}

class _TestSettingsBuilderState extends State<TestSettingsBuilder> {
  TextEditingController timeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CheckboxListTile(
        //   title: const Text("Does the test have a time limit?"),
        //   value: widget.testSettingsData.isTimeLimited,
        //   onChanged: (value) {
        //     setState(() {
        //       widget.testSettingsData.isTimeLimited = value!;
        //       if (value == false) {
        //         widget.testSettingsData.time = 0;
        //         timeTextController.text = "";
        //       }
        //     });
        //   },
        //   secondary: const Icon(Icons.hourglass_empty_rounded),
        // ),
        // Visibility(
        //   visible: widget.testSettingsData.isTimeLimited,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         flex: 3,
        //         child: Slider(
        //           value: widget.testSettingsData.time.toDouble(),
        //           label: "${widget.testSettingsData.time} min.",
        //           min: 0,
        //           max: 60,
        //           divisions: 4,
        //           onChanged: (value) {
        //             setState(() {
        //               widget.testSettingsData.time = value.toInt();
        //               timeTextController.text = value.toString();
        //             });
        //           },
        //         ),
        //       ),
        //       Expanded(
        //         flex: 1,
        //         child: TextField(
        //           decoration: const InputDecoration(labelText: "Time", suffix: Text("min.")),
        //           controller: timeTextController,
        //           keyboardType: TextInputType.number,
        //           inputFormatters: [
        //             FilteringTextInputFormatter.digitsOnly,
        //             LengthLimitingTextInputFormatter(2),
        //           ],
        //           onChanged: (value) {
        //             setState(() {
        //               if (int.parse(value) > 60) {
        //                 widget.testSettingsData.time = 60;
        //                 timeTextController.text = 60.toString();
        //               } else {
        //                 widget.testSettingsData.time = int.parse(value);
        //               }
        //             });
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // CheckboxListTile(
        //   title: const Text("Show the correct answers at the end of the test?"),
        //   value: widget.testSettingsData.toShowCorrectAnswersAfter,
        //   onChanged: (value) {
        //     setState(() {
        //       widget.testSettingsData.toShowCorrectAnswersAfter = value!;
        //     });
        //   },
        //   secondary: const Icon(Icons.check_circle_outline),
        // ),
        // CheckboxListTile(
        //   title: const Text("Show the number of correct answers in the question?"),
        //   value: widget.testSettingsData.toShowShowAnswersNumber,
        //   onChanged: (value) {
        //     setState(() {
        //       widget.testSettingsData.toShowShowAnswersNumber = value!;
        //     });
        //   },
        //   secondary: const Icon(Icons.format_list_numbered),
        // ),
        CheckboxListTile(
          title: const Text("Shuffle the answers?"),
          value: widget.testSettingsData.toShuffleAnswers,
          onChanged: (value) {
            setState(() {
              widget.testSettingsData.toShuffleAnswers = value!;
            });
          },
          secondary: const Icon(Icons.repeat_outlined),
        ),
        CheckboxListTile(
          title: const Text("Shuffle the questions?"),
          value: widget.testSettingsData.toShuffleQuestions,
          onChanged: (value) {
            setState(() {
              widget.testSettingsData.toShuffleQuestions = value!;
            });
          },
          secondary: const Icon(Icons.repeat_on),
        ),
      ],
    );
  }
}
