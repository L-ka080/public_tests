import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:public_tests/data/answer_data.dart';
import 'package:public_tests/data/result_data.dart';
import 'package:public_tests/widgets/Misc/my_card.dart';

class DesktopResultPage extends StatelessWidget {
  final ResultData resultData;

  const DesktopResultPage({
    required this.resultData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result by ${resultData.userName}"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: resultData.results.length,
                  itemBuilder: (context, index) {
                    return MyCard(
                      title: resultData.results[index].questionTitle,
                      contents: Column(
                        children: getAnswerResultTiles(
                            resultData.results[index].answers),
                      ),
                      sizeDeminisher: 1,
                    );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    MyCard(
                      title: "Completion Time",
                      contents: Text(
                        "${DateTime.fromMillisecondsSinceEpoch(resultData.completionTime)}",
                      ),
                      avatar: const Icon(Icons.calendar_month_outlined),
                      sizeDeminisher: 2,
                    ),
                    SizedBox(
                      height: 350,
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: Card(
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            barGroups: [
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(
                                    toY: resultData.questionNumber.toDouble(),
                                    color: Colors.blue,
                                    width: 20,
                                  )
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(
                                    toY: resultData.completedNumber.toDouble(),
                                    color: Colors.green,
                                    width: 20,
                                  )
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(
                                    toY: resultData.correctAnswersNumber
                                        .toDouble(),
                                    color: Colors.orangeAccent,
                                    width: 20,
                                  )
                                ],
                              ),
                            ],
                            gridData: const FlGridData(show: false),
                            titlesData: const FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                  axisNameSize: 25,
                                  drawBelowEverything: true,
                                  axisNameWidget: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        child: Text("Question Amount"),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        child: Text("Completed Questions"),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        child: Text("Correct Answers"),
                                      ),
                                    ],
                                  )),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                axisNameSize: 30,
                                axisNameWidget: Text(
                                  "Test Results",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getAnswerResultTiles(List<AnswerData> data) {
    List<Widget> resultList = [];

    for (var entry in data) {
      resultList.add(
        CheckboxListTile(
          value: entry.isAnswerChecked,
          onChanged: null,
          title: Text(entry.answerTitle ?? "Empty answer"),
        ),
      );
    }

    return resultList;
  }
}
