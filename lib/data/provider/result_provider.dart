import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  String userID;
  String userName;
  String resultData;

  ResultProvider({
    this.userID = "",
    this.userName = "",
    this.resultData = "",
  });
}
