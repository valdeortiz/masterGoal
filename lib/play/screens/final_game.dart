import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:mastergoal/menu/pages/menu_screen.dart';
import 'package:mastergoal/widgets/boton_siguiente.dart';
import 'package:provider/provider.dart';

class FinalGameScreen extends StatefulWidget {
  static const path = '/final_game';
  @override
  _FinalGameScreenState createState() => _FinalGameScreenState();
}

class _FinalGameScreenState extends State<FinalGameScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _confettiController.play();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/successful.json',
                // repeat: false,
                // animate: true,
              ),
              Text(
                context.select((GameCoordProvider gamePro) => gamePro.winner()),
                style: const TextStyle(
                    color: Color(0xFF408ab8),
                    fontSize: 45.0,
                    letterSpacing: 15.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BotonSiguiente(
                  titulo: "Regresar",
                  onTap: () =>
                      Navigator.of(context).pushNamed(MenuPrincipal.menuPath),
                ),
              ),
            ],
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.red
            ],
            maxBlastForce: 200,
            minBlastForce: 100,
            gravity: 0.7,
            numberOfParticles: 100,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ],
      ),
    );
  }
}
