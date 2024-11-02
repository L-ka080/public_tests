import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:public_tests/api%20handler/api_handler.dart';
import 'package:public_tests/constants/routes.dart';
import 'package:public_tests/data/provider/prefs_provider.dart';
import 'package:public_tests/data/provider/test_provider.dart';
import 'package:public_tests/data/provider/user_provider.dart';
import 'package:public_tests/pages/new_test/desktop_new_test.dart';

import 'package:public_tests/widgets/Misc/my_textfield.dart';
import 'package:public_tests/widgets/Pages/centered_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Public tests App"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.logInRoute);
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
                  "Sign in",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MyTextfield(
                    textController: loginController,
                    hintText: "Your username",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MyTextfield(
                    textController: emailController,
                    hintText: "Your e-mail",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: passwordController,
                    style: const TextStyle(fontSize: 22),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Your password",
                      hintStyle: const TextStyle(fontSize: 22),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: ElevatedButton(
                          onPressed: () async {
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text);
                                
                            if (!await ApiHandler.verifyUserName(
                                loginController.text,
                                passwordController.text)) {
                              SnackBar message = SnackBar(
                                content: Text(
                                    "Username '${loginController.text}' is already taken"),
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(message);
                              } else if (!emailValid) {
                                SnackBar message = SnackBar(
                                  content: Text(
                                      "Please check your e-mail (${emailController.text}) writing"),
                                );

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(message);
                                }
                              }
                            } else {
                              UserLoginCredsDTO? userCreds =
                                  await ApiHandler.registerUser(
                                loginController.text,
                                passwordController.text,
                                emailController.text,
                              );

                              if (userCreds != null) {
                                if (context.mounted) {
                                  loginController.clear();
                                  passwordController.clear();

                                  context.read<UserProvider>().addLoginData(
                                        userName: userCreds.userName!,
                                        userToken: userCreds.token!,
                                      );

                                  userCreds.isLoggedIn = true;

                                  context
                                      .read<TestProvider>()
                                      .fetchUserTests(userCreds.token!);
                                  context
                                      .read<PrefsProvider>()
                                      .preferences
                                      .setString(
                                        "userCreds",
                                        userCreds.toJson(),
                                      );

                                  Navigator.pushReplacementNamed(
                                      context, Routes.homePage);
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.primaryContainer),
                          ),
                          child: const Text("Sign in"),
                        ),
                      )
                    ],
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
