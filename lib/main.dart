import 'package:flutter/material.dart';
import 'package:mastergoal/menu/pages/menu_screen.dart';
import 'package:mastergoal/play/screens/play_screen.dart';
import 'package:mastergoal/sign_in/pages/sign_in_screen.dart';
import 'package:mastergoal/tutorial/pages/tutorial_screen.dart';
import 'package:mastergoal/values/colors_app.dart';
import 'package:mastergoal/values/theme_app.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Flutter Demo',
        // themeMode: ThemeMode.light,
        darkTheme: ThemeData(
          textTheme: textThemeDark,
          scaffoldBackgroundColor: backgroundDark,
          iconTheme: iconThemeDark,
          primaryIconTheme: iconThemeDark,
        ),
        theme: ThemeData(
          textTheme: textTheme,
          scaffoldBackgroundColor: background,
          iconTheme: iconThemeData1,
          primaryIconTheme: iconThemeData1,
        ),
        // initialRoute: SignIn.singInPath,
        initialRoute: PlayScreen.playScreenPath,
        routes: {
          SignIn.singInPath: (context) => SignIn(),
          MenuPrincipal.menuPath: (context) => const MenuPrincipal(),
          TutorialScreen.tutorialScreenPath: (context) =>
              const TutorialScreen(),
          PlayScreen.playScreenPath: (context) => const PlayScreen(),
        },
      ),
    );
  }
}
