import 'package:flutter/material.dart';
import 'package:mastergoal/menu/pages/menu_screen.dart';
import 'package:mastergoal/play/screens/play_screen.dart';
import 'package:mastergoal/sign_in/pages/login_screen.dart';
import 'package:mastergoal/sign_in/pages/sign_in_screen.dart';
import 'package:mastergoal/tutorial/pages/tutorial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Login.loginPath,
      routes: {
        Login.loginPath: (context) => const Login(),
        SignIn.singInPath: (context) => SignIn(),
        MenuPrincipal.menuPath: (context) => const MenuPrincipal(""),
        TutorialScreen.tutorialScreenPath: (context) => const TutorialScreen(),
        PlayScreen.playScreenPath: (context) => const PlayScreen(),
      },
    );
  }
}
