import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:public_tests/data/question_data.dart';
import 'package:public_tests/data/result_data.dart';
import 'package:public_tests/data/test_data.dart';
import 'package:public_tests/data/test_settings_data.dart';
import 'package:public_tests/extensions/custom_data_extensions.dart';

class ApiHandler {
  // static const String _baseUrl = "http://localhost:5000";
  // static const String _baseTestUrl = "http://localhost:5056";
  static const String _base = "localhost:5056";

  static const Map<String, String> defaultHeadersDev = {
    HttpHeaders.accessControlAllowOriginHeader: "http://localhost:55001",
  };

  static const Map<String, String> defaultHeaders = {
    HttpHeaders.accessControlAllowOriginHeader: "http://localhost:55000",
  };

  static const Map<String, String> defaultPostHeadersDev = {
    HttpHeaders.accessControlAllowOriginHeader: "http://localhost:55001",
  };

  static Future<int> getData(String loadFrom) async {
    Uri uri = Uri.http(_base, "api/$loadFrom");

    final response = await http.get(uri, headers: defaultHeadersDev);

    return response.statusCode;
  }

  static Future<UserLoginCredsDTO?> loginUser(
      String userName, String password) async {
    Uri uri = Uri.http(_base, "api/user/login");

    final userCreds =
        UserLoginCreds(userName: userName, password: password).toJSON();

    final response =
        await http.post(uri, body: userCreds, headers: defaultHeadersDev);

    if (response.statusCode == 200) {
      print("(Login) API Response: ${response.statusCode} | ${response.body}");
      return UserLoginCredsDTO.fromJSON(jsonDecode(response.body));
    } else {
      print("(Login) API Response: ${response.statusCode} | ${response.body}");
      return null;
    }
  }

  static Future<UserLoginCredsDTO?> registerUser(
      String userName, String password, String email) async {
    Uri uri = Uri.http(_base, "api/user/register");

    final userCredsJson =
        UserLoginCreds(userName: userName, password: password, email: email)
            .toJSON();

    print("$userName | $password | $email");
    print(userCredsJson);

    final response =
        await http.post(uri, body: userCredsJson, headers: defaultHeadersDev);

    if (response.statusCode == 200) {
      print(
          "(Register) API Response: ${response.statusCode} | ${response.body.toString()}");
      return UserLoginCredsDTO.fromJSON(jsonDecode(response.body));
    } else {
      print(
          "(Register) API Response: ${response.statusCode} | ${response.body.toString()}");
      return null;
    }
  }

  static Future<bool> verifyUserName(String userName, String password) async {
    Uri uri = Uri.http(_base, "api/user/verify");

    final userCreds =
        UserLoginCreds(userName: userName, password: password).toJSON();

    print(userCreds);

    final response =
        await http.post(uri, body: userCreds, headers: defaultHeadersDev);

    if (response.statusCode == 200) {
      return true;
    } else {
      print(
          "(Verify) API Response: ${response.statusCode} | ${response.body.toString()}");
      return false;
    }
  }

  static Future<List<TestData>> getAllTests() async {
    Uri uri = Uri.http(_base, "api/test");

    final response = await http.get(uri, headers: defaultHeadersDev);

    List<TestData>? loadedTests = [];

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);

      for (Map<String, dynamic> entry in dataList) {
        TestSettingsData testSettings =
            TestSettingsData.fromJsonString(jsonDecode(entry["testSettings"]));

        TestData testData = TestData(
          testId: entry["id"],
          title: entry["title"],
          createdOn: entry["createdOn"],
          results: [],
          testSettings: testSettings,
        );

        List<dynamic> questionsDataJsonList = jsonDecode(entry["questionData"]);
        List<QuestionData> questionDatas =
            questionsDataJsonList.fromJsonQuestions();

        testData.results = await getUserResults(testData.testId!);

        testData.questions = questionDatas;

        loadedTests.add(testData);
      }

      if (dataList.isEmpty) {
        return [];
      }

      return loadedTests;
    } else {
      print(
        "(GetAllTests) API Response: ${response.statusCode} | ${response.body.toString()}",
      );
    }

    return [];
  }

  static Future<List<TestData>?> getUserTests(String userToken) async {
    Uri uri = Uri.http(_base, "api/test/user");

    Map<String, String> customHeaders = {
      HttpHeaders.authorizationHeader: "Bearer $userToken",
      HttpHeaders.contentTypeHeader: "text/json",
    };

    customHeaders.addAll(defaultHeadersDev);

    final response = await http.get(uri, headers: customHeaders);

    List<TestData> loadedTests = [];
    print("(GetUserTests) API Response: ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> dataList = jsonDecode(response.body);

      for (Map<String, dynamic> entry in dataList) {
        TestSettingsData testSettings =
            TestSettingsData.fromJsonString(jsonDecode(entry["testSettings"]));

        TestData testData = TestData(
            testId: entry["id"],
            title: entry["title"],
            createdOn: entry["createdOn"],
            results: [],
            testSettings: testSettings);

        List<dynamic> questionsDataJsonList = jsonDecode(entry["questionData"]);
        List<QuestionData> questionDatas =
            questionsDataJsonList.fromJsonQuestions();

        testData.results = await getUserResults(testData.testId!);

        testData.questions = questionDatas;

        loadedTests.add(testData);
      }

      if (dataList.isEmpty) {
        return [];
      }

      // for (Map<String, dynamic> data in dataList) {
      //   TestData testData = TestData.fromJSON(data);

      //   loadedTests.add(testData);
      // }

      return loadedTests;
    } else {
      print("${response.statusCode} | ${response.body.toString()}");
    }

    return [];
  }

  static Future<List<ResultData>> getUserResults(int testId) async {
    Uri uri = Uri.http(_base, "api/test/result/$testId");

    // Map<String, String> customHeaders = {
    //   HttpHeaders.authorizationHeader: "Bearer $userToken",
    // };

    // customHeaders.addAll(defaultHeadersDev);

    List<ResultData> resultList = [];

    final response = await http.get(uri, headers: defaultHeadersDev);

    print("(GetUserResults) API Response: ${response.statusCode}");

    if (response.statusCode == 200) {
      List<dynamic> responseBody = jsonDecode(response.body);

      for (var resultJson in responseBody) {
        resultList.add(ResultData.fromJsonString(resultJson));
      }

      return resultList;
    }

    return [];
  }

  static Future<int?> createNewTest(TestData testData, String userToken) async {
    Uri uri = Uri.http(_base, "api/test/new");

    String testDataJson = testData.toJson();

    Map<String, String> customHeaders = {
      HttpHeaders.authorizationHeader: "Bearer $userToken",
      HttpHeaders.contentTypeHeader: "text/json"
    };

    customHeaders.addAll(defaultPostHeadersDev);

    final response =
        await http.post(uri, body: testDataJson, headers: customHeaders);

    // print(
    //     "(NewTest) API Response: ${response.statusCode} | ${response.body.toString()}");

    if (response.statusCode == 201) {
      return jsonDecode(response.body)["id"] as int;
    } else {
      print("${response.statusCode} | ${response.body.toString()}");
      return null;
    }
  }

  static void createNewResult(
      int testId, ResultData resultData, String userToken) async {
    Uri uri = Uri.http(_base, "api/test/result/$testId");

    String resultDataJson = resultData.toJson();

    Map<String, String> customHeaders = {
      HttpHeaders.authorizationHeader: "Bearer $userToken",
      HttpHeaders.contentTypeHeader: "text/json"
    };

    customHeaders.addAll(defaultHeadersDev);

    final response =
        await http.post(uri, body: resultDataJson, headers: customHeaders);

    if (response.statusCode != 201) {
      print(
          "(NewResult) API Response: ${response.statusCode} | ${response.body.toString()}");
    }
  }

  // static Future<int> createNewTestUserConnection(
  //     int testId, String userToken) async {
  //   Uri uri = Uri.http(_base, "api/test/user/$testId");

  //   Map<String, String> customHeaders = {
  //     HttpHeaders.authorizationHeader: "Bearer $userToken",
  //   };

  //   customHeaders.addAll(defaultPostHeadersDev);

  //   final response = await http.post(uri, body: testId, headers: customHeaders);

  //   print(
  //       "(NewTestConnect) API Response: ${response.statusCode} | ${response.body.toString()}");

  //   return response.statusCode;
  // }

  static Future<bool> deleteSelectedTest(int? testId) async {
    if (testId != null) {
      Uri uri = Uri.http(_base, "api/test/$testId");

      final response = await http.delete(uri);

      print("${response.statusCode} | ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  // static Future<int> passData(String loadTo, String data) {
  //   return 200;
  // }
}

class UserLoginCreds {
  String? userName;
  String? password;
  String? email;

  UserLoginCreds({required this.userName, required this.password, this.email});

  Map<String, String> toJSON() {
    //   if (email != null) {
    //     Map<String, String> toJsonEncode = {
    //       "UserName": userName ?? "",
    //       "Password": password ?? "",
    //       "Email": email ?? ""
    //     };
    //     return jsonEncode(toJsonEncode);
    //   } else {
    //     Map<String, String> toJsonEncode = {
    //       "UserName": userName ?? "",
    //       "Password": password ?? "",
    //     };
    //     return jsonEncode(toJsonEncode);
    //   }

    if (email != null) {
      return {
        "UserName": userName ?? "",
        "Password": password ?? "",
        "Email": email ?? ""
      };
    } else {
      return {
        "UserName": userName ?? "",
        "Password": password ?? "",
      };
    }
  }

  String toURIString() {
    return "?UserName=$userName&Password=$password";
  }

  UserLoginCreds.fromJSON(Map<String, String> json)
      : userName = json["UserName"] ?? "",
        password = json["Password"] ?? "";
}

class UserLoginCredsDTO {
  String? userName;
  String? email;
  String? token;
  bool isLoggedIn = false;

  UserLoginCredsDTO.fromJSON(Map<String, dynamic>? jsonBody) {
    if (jsonBody == null || jsonBody.isEmpty) {
      userName = null;
      email = null;
      token = null;
      isLoggedIn = false;
    } else {
      userName = jsonBody["userName"].toString();
      email = jsonBody["email"].toString();
      token = jsonBody["token"].toString();
      isLoggedIn = jsonBody["isLoggedIn"].toString().toLowerCase() == 'true'
          ? true
          : false;
    }
  }

  String toJson() {
    Map<String, String> mappedUserCreds = {
      "userName": userName ?? "",
      "email": email ?? "",
      "token": token ?? "",
      "isLoggedIn": isLoggedIn.toString()
    };

    return jsonEncode(mappedUserCreds);
  }
  // static UserLoginDTOCreds? fromJSON(Map<String, dynamic>? jsonBody) {

  // }
}
