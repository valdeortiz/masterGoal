import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/play/screens/play_screen.dart';
import 'package:mastergoal/tutorial/pages/tutorial_screen.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal(this.userName, {Key? key}) : super(key: key);
  static const String menuPath = '/menu';
  final String userName;
  final TextStyle _style = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/stadium3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset('assets/lottie/soccer-player.json'),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Bienvenido $userName",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              fontFamily: 'NovaRound',
                            )),
                        TextSpan(
                          text: " $userName",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[200],
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, TutorialScreen.tutorialScreenPath);
                  },
                  child: Text(
                    "Tutorial",
                    style: _style,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(PlayScreen.playScreenPath);
                  },
                  child: Text(
                    "Jugar",
                    style: _style,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Configuracion",
                    style: _style,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
