import 'package:flutter/material.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/data/test_settings_data.dart';
import 'package:public_tests/pages/tests/desktop_test_page.dart';

class TestCard extends StatelessWidget {
  final TestData data;
  final VoidCallback? onTestDelete;
  
  const TestCard({
    super.key,
    required this.data,
    required this.onTestDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Map<String, String>? settingsData = checkTestSettings(data.testSettings);
    TestSettingsData? testSettings = data.testSettings;

    return SizedBox(
      // height: 150,
      width: MediaQuery.sizeOf(context).width / 4,
      child: Card(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              data.title.isEmpty ? "Untitled Test" : data.title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
          subtitle: Wrap(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: Chip(
                  avatar: const Icon(Icons.check),
                  label: Text(testSettings.testType),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: Chip(
                  avatar: const Icon(Icons.question_answer_outlined),
                  label: Text("Questions: ${data.questions.length}"),
                ),
              ),
              Visibility(
                visible: testSettings.toShuffleQuestions,
                child: const Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Chip(
                    label: Text("Shuffled Questions"),
                    avatar: Icon(Icons.repeat_outlined),
                  ),
                ),
              ),
              Visibility(
                visible: testSettings.toShuffleAnswers,
                child: const Padding(
                  padding: EdgeInsets.only(right: 5, bottom: 5),
                  child: Chip(
                    label: Text("Shuffled Answers"),
                    avatar: Icon(Icons.repeat_outlined),
                  ),
                ),
              )
              // Text(testSettings!.testType == "Survey" || testSettings.time == 0
              // ? "No time limit for this test"
              // : "Test Time: ${testSettings.time} min.")
            ],
          ),
          trailing: Visibility(
            visible: onTestDelete != null,
            child: IconButton(
              onPressed: onTestDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DesktopTestPage(data: data),
              ),
            );
          },
        ),
      ),
    );
  }

  // String timeCheck(int? time) {
  //   // int hours = 0;
  //   // int minutes = 0;
  //   // int seconds = 0;

  //   if (time == null) {
  //     return ".";
  //   } else {
  //     DateTime readyTime = DateTime.fromMillisecondsSinceEpoch(time);
  //     String formattedTime = TimeOfDay.now().toString();
  //     return formattedTime;
  //     // return DateTime.fromMillisecondsSinceEpoch(int.parse(time)).hour.toString();
  //   }
  // }

  Map<String, String>? checkTestSettings(TestSettingsData? settings) {
    Map<String, String> settingsData = {};

    if (settings == null) {
      return null;
    }

    if (settings.time == 0) {
      settingsData
          .addEntries([const MapEntry("Time", "Test is not time limited")]);
    } else {
      settingsData
          .addEntries([MapEntry("Time", "Time limit: ${settings.time} min.")]);
    }

    return settingsData;
  }
}
