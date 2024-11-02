import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String userName;
  // String userID;
  String userToken;
  bool isLoggedIn;

  UserProvider({
    required this.userName,
    // this.userID = "",
    required this.userToken,
    this.isLoggedIn = false,
  });

  void addLoginData({
    required String userName,
    String? userID,
    required String userToken,
  }) async {
    this.userName = userName;
    this.userToken = userToken;
    isLoggedIn = true;

    notifyListeners();
  }

  void clear() {
    userName = "";
    userToken = "";
    isLoggedIn = false;
  }

  // void addLoginDataFromCreds({
  //   required UserLoginDTOCreds? loginCreds,
  // }) async {
  //   if (loginCreds != null) {
  //     userName = loginCreds.userName;
  //     userToken = loginCreds.token;
  //     isLoggedIn = true;
  //   }
  // }
}
