import 'package:flutter/material.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';
import 'package:mastergoal/pieces/player.dart';
import 'package:collection/collection.dart';

enum GameType { pc, jugador }

class GameCoordProvider extends ChangeNotifier {
  int player1Gols = 0;
  int player2Gols = 0;
  String? namePlayer1;
  String? namePlayer2 = 'PC';
  int maxGols = 1;
  bool isWin = false;
  GameType gameType = GameType.pc;

  PlayerType currentTurn = PlayerType.player1;
  PlayerType? currentBallTurn;
  // List<MgPiece> moveInicial = [
  //   BallPiece(PlayerType.ball, Location(6, 6),
  //       [Location(6, 6), Location(5, 6), Location(4, 6)]),
  //   Player(PlayerType.player1, Location(3, 6),
  //       [Location(3, 6), Location(4, 6), Location(5, 6)]),
  //   Player(PlayerType.player2, Location(9, 6),
  //       [Location(9, 6), Location(10, 6), Location(11, 6)]),
  // ];
  // [Location(6, 5), Location(6, 7), Location(7, 6), Location(5, 6), Location(5, 6)];
  final ballInicial = BallPiece(PlayerType.ball, Location(6, 6), [
    // movimiento de horizontal
    Location(6, 2), Location(6, 3), Location(6, 4), Location(6, 5),
    Location(6, 7), Location(6, 8), Location(6, 9), Location(6, 10),
    // movimiento vertical
    Location(2, 6), Location(3, 6), Location(4, 6), Location(5, 6),
    Location(7, 6), Location(8, 6), Location(9, 6), Location(10, 6),
  ]);
  final player1Inicial = Player(PlayerType.player1, Location(3, 6),
      [Location(7, 6), Location(4, 6), Location(5, 6)]);
  final player2Inicial = Player(PlayerType.player2, Location(9, 6),
      [Location(12, 6), Location(10, 6), Location(11, 6)]);

  List<MgPiece> pieces = [
    BallPiece(PlayerType.ball, Location(6, 6), [
      // movimiento de horizontal
      Location(6, 2), Location(6, 3), Location(6, 4), Location(6, 5),
      Location(6, 7), Location(6, 8), Location(6, 9), Location(6, 10),
      // movimiento vertical
      Location(2, 6), Location(3, 6), Location(4, 6), Location(5, 6),
      Location(7, 6), Location(8, 6), Location(9, 6), Location(10, 6),
    ]),
    Player(PlayerType.player1, Location(3, 6),
        [Location(3, 6), Location(4, 6), Location(5, 6)]),
    Player(PlayerType.player2, Location(9, 6),
        [Location(9, 6), Location(10, 6), Location(11, 6)]),
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
    pieces[0] = ballInicial;
    pieces[1] = player1Inicial;
    pieces[2] = player2Inicial;
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
      ballInicial,
      player1Inicial,
      player2Inicial,
    ];
    // notifyListeners();
  }
}
