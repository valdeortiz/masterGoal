import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/tutorial/pages/tutorial_screen.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({Key? key}) : super(key: key);
  static const String menuPath = '/menu';
  final TextStyle _style = const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/madera.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/lottie/soccer-player.json'),
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
                onPressed: () {},
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
    );
  }
}
