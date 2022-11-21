import 'package:flutter/material.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';

class GameCoordProvider extends ChangeNotifier {
  int player1Gols = 0;
  int player2Gols = 0;
  PlayerType currentTurn = PlayerType.player1;
  void changeTurn(piece) {
    currentTurn = piece.pieceType == PlayerType.player1
        ? PlayerType.player2
        : PlayerType.player1;
  }

  void player1Gol() {
    player1Gols += 1;
    notifyListeners();
  }

  void player2Gol() {
    player2Gols += 1;
    notifyListeners();
  }

  void initGame() {}
}
