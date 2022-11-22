import 'package:flutter/material.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';
import 'package:mastergoal/pieces/player.dart';

class GameCoordProvider extends ChangeNotifier {
  int player1Gols = 0;
  int player2Gols = 0;
  PlayerType currentTurn = PlayerType.player1;
  List<MgPiece> pieces = [
    BallPiece(PlayerType.ball, Location(6, 6)),
    Player(PlayerType.player1, Location(5, 6)),
    Player(PlayerType.player2, Location(7, 6)),
  ];
  void changeTurn() {
    currentTurn = currentTurn == PlayerType.player1
        ? PlayerType.player2
        : PlayerType.player1;
  }

  void setGol() {
    switch (currentTurn) {
      case PlayerType.player1:
        player1Gols += 1;
        currentTurn = PlayerType.player2;
        break;
      case PlayerType.player2:
        player2Gols += 1;
        currentTurn = PlayerType.player1;
        break;
      default:
        break;
    }

    notifyListeners();
  }

  // factory GameCoordProvider.newGame() {
  //   return GameCoordProvider(
  //     [
  //       BallPiece(PlayerType.ball, Location(6, 6)),
  //       Player(PlayerType.player1, Location(5, 6)),
  //       Player(PlayerType.player2, Location(7, 6))
  //     ],
  //   );
  // }
}
