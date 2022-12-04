import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:mastergoal/play/screens/play_screen.dart';
import 'package:mastergoal/tutorial/pages/tutorial_screen.dart';
import 'package:provider/provider.dart';

class MenuPrincipal extends StatelessWidget {
  MenuPrincipal({Key? key}) : super(key: key);
  static const String menuPath = '/menu';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      //width: MediaQuery.of(context).size.width,

      //Background de la pantalla
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/stadium3.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Titulo de Bienvenida
            RichText(
              text: TextSpan(
                  text: "Bienvenido/a \n",
                  style: const TextStyle(
                      fontFamily: 'NovaRound',
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text:
                            Provider.of<GameCoordProvider>(context).namePlayer1,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 15, 63, 85),
                            fontFamily: 'Oswald')),
                  ]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 80,
            ),

            //Button Jugar
            Container(
              decoration: decorationContainer,
              width: 260,
              height: 50,
              child: ElevatedButton.icon(
                style: styleElevatedButton,
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  size: 50,
                ),
                label: const Text(
                  "Jugar  ",
                  style: TextStyle(
                      fontFamily: 'NovaRound',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(PlayScreen.playScreenPath);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //Button Tutorial
            Container(
              decoration: decorationContainer,
              width: 260,
              height: 50,
              child: ElevatedButton.icon(
                style: styleElevatedButton,
                icon: const Icon(
                  Icons.menu_book_rounded,
                  size: 40,
                ),
                label: const Text(
                  "Tutorial",
                  style: TextStyle(
                      fontFamily: 'NovaRound',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(TutorialScreen.tutorialScreenPath);
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //Button Ajustes
            Container(
              decoration: decorationContainer,
              width: 260,
              height: 50,
              child: ElevatedButton.icon(
                style: styleElevatedButton,
                icon: const Icon(
                  Icons.miscellaneous_services_rounded,
                  size: 40,
                ),
                label: const Text(
                  "Ajustes",
                  style: TextStyle(
                      fontFamily: 'NovaRound',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            //Gif
            Lottie.asset('assets/lottie/soccer-player.json', width: 250),
          ],
        ),
      ),
    )));
  }

  //Style para los Buttons
  final styleElevatedButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)));

  //BoxDecoration para el decoration de los Container
  final BoxDecoration decorationContainer = const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/button.png"), fit: BoxFit.fill));
}
