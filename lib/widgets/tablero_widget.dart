import 'package:flutter/material.dart';

class TableroPuntuacion extends StatelessWidget {
  const TableroPuntuacion(
      {Key? key, required this.player1Gol, required this.player2Gol})
      : super(key: key);

  final TextStyle _style =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final int player1Gol;
  final int player2Gol;

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  "Home",
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
                  "$player1Gol",
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
                  "$player2Gol",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                // height: sizeScreen,
                // width: sizeScreen,
                alignment: Alignment.center,
                child: Text(
                  "Away",
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
