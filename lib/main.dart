import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mastergoal/clock/providers/coubtdown_provider.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:mastergoal/menu/pages/menu_screen.dart';
import 'package:mastergoal/play/screens/play_screen.dart';
import 'package:mastergoal/sign_in/pages/login_screen.dart';
import 'package:mastergoal/sign_in/pages/sign_in_screen.dart';
import 'package:mastergoal/tutorial/pages/tutorial_screen.dart';
import 'package:mastergoal/values/colors_app.dart';
import 'package:mastergoal/values/theme_app.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    const [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CountdownProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => GameCoordProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Master Goal',
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

          initialRoute: Login.loginPath,
          // initialRoute: PlayScreen.playScreenPath,
          routes: {
            Login.loginPath: (context) => const Login(),
            SignIn.singInPath: (context) => SignIn(),
            MenuPrincipal.menuPath: (context) => MenuPrincipal("user"),
            TutorialScreen.tutorialScreenPath: (context) =>
                const TutorialScreen(),
            PlayScreen.playScreenPath: (context) => const PlayScreen(),
          },
        ),
      ),
    );
  }
}
