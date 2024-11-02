import 'package:flutter/material.dart';
import 'package:public_tests/data/result_data.dart';
import 'package:public_tests/pages/results/desktop_result_page.dart';

class ResultCard extends StatelessWidget {
  final ResultData resultData;

  const ResultCard({
    required this.resultData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 4,
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Result by ${resultData.userName}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          subtitle: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 5),
                child: Chip(
                  label: Text("${DateTime.fromMillisecondsSinceEpoch((resultData.completionTime / 1000).truncate())}"),
                  avatar: const Icon(Icons.calendar_month_outlined),
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DesktopResultPage(resultData: resultData),
              ),
            );
          },
        ),
      ),
    );
  }
}
