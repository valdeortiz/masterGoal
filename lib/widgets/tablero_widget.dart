import 'package:flutter/material.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:provider/provider.dart';

class TableroPuntuacion extends StatelessWidget {
  const TableroPuntuacion({Key? key}) : super(key: key);

  final TextStyle _style =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // final game = Provider.of<GameCoordProvider>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                alignment: Alignment.center,
                width: 100,
                child: Text(
                  "Jugador 1",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border(
                    left: BorderSide(
                      //                   <--- left side
                      // color: Colors.black,
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  context.select((GameCoordProvider gamePro) =>
                      gamePro.player1Gols.toString()),
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border(
                    left: BorderSide(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    right: BorderSide(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ),
                // height: sizeScreen,
                // width: sizeScreen,
                alignment: Alignment.center,
                child: Text(
                  context.select((GameCoordProvider gamePro) =>
                      gamePro.player2Gols.toString()),
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                // height: sizeScreen,
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  "Jugador 2",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
