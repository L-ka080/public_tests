import 'package:flutter/material.dart';
import 'package:public_tests/data/test_data.dart';

class TestCard extends StatelessWidget {
  final TestData data;
  const TestCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.sizeOf(context).width / 4,
      child: Card(
        child: ListTile(
          title: Text(data.title ?? "Test"),
          subtitle:
              Text("There is ${data.questions.length} questions${timeCheck(0)}"),
          onTap: () {},
        ),
      ),
    );
  }

  String timeCheck(int? time) {
    // int hours = 0;
    // int minutes = 0;
    // int seconds = 0;

    if (time == null) {
      return ".";
    } else {
      DateTime readyTime = DateTime.fromMillisecondsSinceEpoch(time);
      String formattedTime = TimeOfDay.now().toString();
      return formattedTime;
      // return DateTime.fromMillisecondsSinceEpoch(int.parse(time)).hour.toString();
    }
  }
}
