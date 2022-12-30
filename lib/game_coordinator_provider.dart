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
  String? namePlayer2;
  int maxGols = 1;
  bool isWin = false;
  GameType gameType = GameType.pc;

  PlayerType currentTurn = PlayerType.player1;
  PlayerType? currentBallTurn;

  final List<Location> ballInicialList = [
    // movimiento de horizontal
    Location(6, 2), Location(6, 3), Location(6, 4), Location(6, 5),
    Location(6, 7), Location(6, 8), Location(6, 9), Location(6, 10),
    // movimiento vertical
    Location(2, 6), Location(3, 6), Location(4, 6), Location(5, 6),
    Location(7, 6), Location(8, 6), Location(9, 6), Location(10, 6),
  ];

  final List<Location> player1InicialList = [
    // movimientos verticales
    Location(1, 6), Location(2, 6), Location(4, 6), Location(5, 6),
    // movimientos horizontales
    Location(3, 7), Location(3, 8), Location(3, 5), Location(3, 4),
    // movimientos diagonales
    Location(4, 5), Location(2, 5), Location(2, 7), Location(4, 7),
  ];
  final List<Location> player2InicialList = [
    // movimientos verticales
    Location(7, 6), Location(8, 6), Location(10, 6), Location(11, 6),
    // movimientos horizontales
    Location(9, 4), Location(9, 5), Location(9, 7), Location(9, 8),
    // movimientos diagonales
    Location(10, 5), Location(8, 5), Location(8, 7), Location(10, 7),
  ];

  List<MgPiece> pieces = [
    BallPiece(PlayerType.ball, Location(6, 6), [
      // movimiento de horizontal
      Location(6, 2), Location(6, 3), Location(6, 4), Location(6, 5),
      Location(6, 7), Location(6, 8), Location(6, 9), Location(6, 10),
      // movimiento vertical
      Location(2, 6), Location(3, 6), Location(4, 6), Location(5, 6),
      Location(7, 6), Location(8, 6), Location(9, 6), Location(10, 6),
    ]),
    Player(PlayerType.player1, Location(3, 6), [
      // movimientos verticales
      Location(1, 6), Location(2, 6), Location(4, 6), Location(5, 6),
      // movimientos horizontales
      Location(3, 7), Location(3, 8), Location(3, 5), Location(3, 4),
      // movimientos diagonales
      Location(4, 5), Location(2, 5), Location(2, 7), Location(4, 7),
    ]),
    Player(PlayerType.player2, Location(9, 6), [
      // movimientos verticales
      Location(7, 6), Location(8, 6), Location(10, 6), Location(11, 6),
      // movimientos horizontales
      Location(9, 4), Location(9, 5), Location(9, 7), Location(9, 8),
      // movimientos diagonales
      Location(10, 5), Location(8, 5), Location(8, 7), Location(10, 7),
    ]),
  ];

  MgPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);
  // BallPiece ball = BallPiece(PlayerType.ball, Location(6, 6));
  String get turnoActual => (currentTurn == PlayerType.player1
      ? namePlayer1 ?? 'Jugador 1'
      : gameType == GameType.pc
          ? "${namePlayer2 ?? 'Jugador 2'} - PC"
          : namePlayer2 ?? 'Jugador 2');

  bool onPosesion(int x, int y, String turno) {
    if (pieceOfTile(x + 1, y) != null &&
        pieceOfTile(x + 1, y)?.name != "ball" &&
        pieceOfTile(x + 1, y)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x - 1, y) != null &&
        pieceOfTile(x - 1, y)?.name != "ball" &&
        pieceOfTile(x - 1, y)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x + 1, y + 1) != null &&
        pieceOfTile(x + 1, y + 1)?.name != "ball" &&
        pieceOfTile(x + 1, y + 1)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x + 1, y - 1) != null &&
        pieceOfTile(x + 1, y - 1)?.name != "ball" &&
        pieceOfTile(x + 1, y - 1)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x - 1, y + 1) != null &&
        pieceOfTile(x - 1, y + 1)?.name != "ball" &&
        pieceOfTile(x - 1, y + 1)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x - 1, y - 1) != null &&
        pieceOfTile(x - 1, y - 1)?.name != "ball" &&
        pieceOfTile(x - 1, y - 1)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x, y + 1) != null &&
        pieceOfTile(x, y + 1)?.name != "ball" &&
        pieceOfTile(x, y + 1)?.name != turno) {
      return false;
    }
    if (pieceOfTile(x, y - 1) != null &&
        pieceOfTile(x, y - 1)?.name != "ball" &&
        pieceOfTile(x, y - 1)?.name != turno) {
      return false;
    }
    return true;
  }

  // bool onDispute(Location ubi) {
  //   int x = ubi.x;
  //   int y = ubi.y;
  //   int c = 0;
  //   if (pieceOfTile(x + 1, y) != null) c++;
  //   if (pieceOfTile(x - 1, y) != null) c++;
  //   if (pieceOfTile(x + 1, y + 1) != null) c++;
  //   if (pieceOfTile(x + 1, y - 1) != null) c++;
  //   if (pieceOfTile(x - 1, y + 1) != null) c++;
  //   if (pieceOfTile(x - 1, y - 1) != null) c++;
  //   if (pieceOfTile(x, y + 1) != null) c++;
  //   if (pieceOfTile(x, y - 1) != null) c++;
  //   if (c > 1) return true;
  //   return false;
  // }

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
    pieces[0] = BallPiece(PlayerType.ball, Location(6, 6), ballInicialList);
    pieces[1] = Player(PlayerType.player1, Location(3, 6), player1InicialList);
    pieces[2] = Player(PlayerType.player2, Location(9, 6), player2InicialList);
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
    isWin = false;
    currentTurn = PlayerType.player1;
    currentBallTurn;
    pieces = [
      BallPiece(PlayerType.ball, Location(6, 6), ballInicialList),
      Player(PlayerType.player1, Location(3, 6), player1InicialList),
      Player(PlayerType.player2, Location(9, 6), player2InicialList),
    ];
    notifyListeners();
  }

  changeModeType() {
    gameType == GameType.pc
        ? gameType = GameType.jugador
        : gameType = GameType.pc;
    notifyListeners();
  }

  void changeMaxGol(int maxgol) {
    maxGols = maxgol;
    notifyListeners();
  }
}
