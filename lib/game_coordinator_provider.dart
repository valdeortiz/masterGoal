import 'package:flutter/material.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';
import 'package:mastergoal/pieces/player.dart';
import 'package:collection/collection.dart';

class GameCoordProvider extends ChangeNotifier {
  int player1Gols = 0;
  int player2Gols = 0;
  String? namePlayer1;
  String? namePlayer2 = 'PC';
  int maxGols = 1;
  bool isWin = false;

  PlayerType currentTurn = PlayerType.player1;
  PlayerType? currentBallTurn;
  List<MgPiece> pieces = [
    BallPiece(PlayerType.ball, Location(6, 6)),
    Player(PlayerType.player1, Location(3, 6)),
    Player(PlayerType.player2, Location(9, 6)),
  ];

  MgPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);
  // BallPiece ball = BallPiece(PlayerType.ball, Location(6, 6));
  String get turnoActual =>
      (currentTurn == PlayerType.player1 ? namePlayer1 : namePlayer2) ??
      'Sin nombre';

  bool onPosesion(int x, int y) {
    if (pieceOfTile(x + 1, y) != null) return false;
    if (pieceOfTile(x - 1, y) != null) return false;
    if (pieceOfTile(x + 1, y + 1) != null) return false;
    if (pieceOfTile(x + 1, y - 1) != null) return false;
    if (pieceOfTile(x - 1, y + 1) != null) return false;
    if (pieceOfTile(x - 1, y - 1) != null) return false;
    if (pieceOfTile(x, y + 1) != null) return false;
    if (pieceOfTile(x, y - 1) != null) return false;
    return true;
  }

  String winner() {
    if (player1Gols > player2Gols) {
      return namePlayer1 ?? 'Jugador 1';
    }
    if (player2Gols > player1Gols) {
      return namePlayer2 ?? 'Jugador 2';
    }
    if (player1Gols == player2Gols) {
      return 'Empate';
    }
    return '';
  }

  void restart() {
    pieces[0] = BallPiece(PlayerType.ball, Location(6, 6));
    pieces[1] = Player(PlayerType.player1, Location(3, 6));
    pieces[2] = Player(PlayerType.player2, Location(9, 6));
    currentBallTurn = null;
  }

  void changeTurn() {
    currentTurn = currentTurn == PlayerType.player1
        ? PlayerType.player2
        : PlayerType.player1;
  }

  void setGol() {
    switch (currentTurn) {
      case PlayerType.player1:
        player1Gols += 1;
        if (player1Gols >= maxGols) isWin = true;
        currentTurn = PlayerType.player2;
        break;
      case PlayerType.player2:
        player2Gols += 1;
        if (player2Gols >= maxGols) isWin = true;
        currentTurn = PlayerType.player1;
        break;
      default:
        break;
    }

    notifyListeners();
  }

  void newGame() {
    player1Gols = 0;
    player2Gols = 0;
    namePlayer2 = 'PC';
    isWin = false;
    currentTurn = PlayerType.player1;
    currentBallTurn;
    pieces = [
      BallPiece(PlayerType.ball, Location(6, 6)),
      Player(PlayerType.player1, Location(3, 6)),
      Player(PlayerType.player2, Location(9, 6)),
    ];
    // notifyListeners();
  }
}
