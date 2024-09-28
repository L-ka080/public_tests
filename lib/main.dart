import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:public_tests/pages/home/desktop_home_page.dart';
// import 'package:public_tests/pages/home/mobile_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'widgets/responsive_layout.dart';

void main() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(MainApp(preferences: preferences));
}

class MainApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MainApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
            useMaterial3: true),
        home: const DesktopHomePage());
  }
}
