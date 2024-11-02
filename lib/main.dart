import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/constants/routes.dart';
import 'package:public_tests/data/provider/prefs_provider.dart';
import 'package:public_tests/data/provider/result_provider.dart';
import 'package:public_tests/data/provider/test_provider.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/pages/auth/log_in_page.dart';
import 'package:public_tests/pages/auth/sign_in_page.dart';
import 'package:public_tests/pages/home/desktop_all_tests_page.dart';
import 'package:public_tests/pages/home/desktop_home_page.dart';
import 'package:public_tests/pages/new_test/desktop_new_test.dart';
// import 'package:provider/provider.dart';
// import 'package:public_tests/pages/home/mobile_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'widgets/responsive_layout.dart';

void main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  // await preferences.clear();

  setUrlStrategy(const HashUrlStrategy());
  runApp(
    MainApp(
      preferencesInstance: preferences,
    ),
  );
}

class MainApp extends StatelessWidget {
  final SharedPreferences preferencesInstance;

  const MainApp({
    super.key,
    required this.preferencesInstance,
  });

  @override
  Widget build(BuildContext context) {
    // context.watch<PrefsProvider>().setNewPreferences(preferencesInstance);
    UserLoginCredsDTO savedUserData = UserLoginCredsDTO.fromJSON(
        jsonDecode(preferencesInstance.get("userCreds").toString()));
    // context.watch<UserProvider>().addLoginDataFromCreds(loginCreds: savedUserData);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            userName: savedUserData.userName ?? "",
            userToken: savedUserData.token ?? "",
            isLoggedIn: savedUserData.isLoggedIn,
          ),
        ),
        ChangeNotifierProvider(create: (context) => TestProvider()),
        ChangeNotifierProvider(create: (context) => ResultProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                PrefsProvider(preferences: preferencesInstance))
      ],
      child: MaterialApp(
        routes: {
          "/": (context) => const LogInPage(),
          Routes.logInRoute: (context) => const LogInPage(),
          Routes.signInRoute: (context) => const SignInPage(),
          Routes.homePage: (context) => const DesktopHomePage(
              // testData: context.watch<TestProvider>().testData,
              // isLoggedIn: context.read<UserProvider>().isLoggedIn,
              // isLoggedIn: savedUserData.isLoggedIn,
              // isLoggedIn: true,
              ),
          Routes.newTest: (context) => const DesktopNewTest(),
          Routes.allTestsPage: (context) => const DesktopAllTestsPage(),
          // routes.test: (conext) => const TestPage(),
        },
        initialRoute:
            savedUserData.isLoggedIn ? Routes.homePage : Routes.logInRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
            useMaterial3: true),
        // home: const LogInPage()
      ),
    );
  }
}
