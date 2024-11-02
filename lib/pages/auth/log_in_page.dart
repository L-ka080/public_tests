
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/data/provider/prefs_provider.dart';
import 'package:public_tests/data/provider/test_provider.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/widgets/Misc/my_textfield.dart';
import 'package:public_tests/widgets/Pages/centered_page.dart';

import 'package:public_tests/constants/routes.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool isPassObscured = true;

  @override
  void initState() {
    // TODO: Прописать автоматический редарект к HomePage, если есть сохраненные данные
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Public tests App"),
        automaticallyImplyLeading: false,
      ),
      body: CenteredPage(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MyTextfield(
                    textController: loginController,
                    hintText: "Your login",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordController,
                    style: const TextStyle(fontSize: 22),
                    obscureText: isPassObscured,
                    decoration: InputDecoration(
                      labelText: "Your password",
                      hintStyle: const TextStyle(fontSize: 22),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // suffixIcon: IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       isPassObscured = !isPassObscured;
                      //       passwordController.text = passwordController.text;
                      //     });
                      //   },
                      //   icon: isPassObscured
                      //       ? const Icon(Icons.visibility_outlined)
                      //       : const Icon(Icons.visibility_off_outlined),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: OutlinedButton(
                            onPressed: () {
                              // print("Trying to sign in");
                              Navigator.of(context).pushNamed(Routes.signInRoute);
                            },
                            child: const Text("Sign in"),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer)),
                          onPressed: () async {
                            UserLoginCredsDTO? userCreds;

                            userCreds = await ApiHandler.loginUser(
                                loginController.text, passwordController.text);

                            if (userCreds != null) {
                              if (!context.mounted) return;

                              context.read<UserProvider>().addLoginData(
                                    userName: userCreds.userName!,
                                    userToken: userCreds.token!,
                                  );

                              loginController.clear();
                              passwordController.clear();

                              userCreds.isLoggedIn = true;
                              
                              context.read<TestProvider>().fetchUserTests(userCreds.token!);
                              context.read<PrefsProvider>().preferences.setString("userCreds", userCreds.toJson());
                              // context.read<PrefsProvider>().preferences.setBool("isLoggedIn", true);

                              Navigator.pushReplacementNamed(
                                context,
                                Routes.homePage,
                              );
                            } else {
                              return;
                              //  TODO Сделать показ SnakBar с ошибкой вводимых данных
                            }
                          },
                          child: const Text("Log in"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
