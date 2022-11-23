import 'package:collection/collection.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/player.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';

class GameCoordinator {
  final List<MgPiece> pieces;

  // PlayerType currentTurn = PlayerType.player1;
  // Con esta variable verificamos si hay algun jugador que pueda mover la pelota
  // en caso de ser nulo no se puede mover la pelota
  // y en caso de que si se pueda mover se debe asignar el PlayerType a la variable
  PlayerType? currentBallTurn;

  GameCoordinator(this.pieces);

  MgPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);
  // BallPiece ball = BallPiece(PlayerType.ball, Location(6, 6));

  bool onPosesion(int x, int y) {
    if (this.pieceOfTile(x + 1, y) != null) return false;
    if (this.pieceOfTile(x - 1, y) != null) return false;
    if (this.pieceOfTile(x + 1, y + 1) != null) return false;
    if (this.pieceOfTile(x + 1, y - 1) != null) return false;
    if (this.pieceOfTile(x - 1, y + 1) != null) return false;
    if (this.pieceOfTile(x - 1, y - 1) != null) return false;
    if (this.pieceOfTile(x, y + 1) != null) return false;
    if (this.pieceOfTile(x, y - 1) != null) return false;
    return true;
  }

  factory GameCoordinator.newGame() {
    return GameCoordinator(
      [
        BallPiece(PlayerType.ball, Location(6, 6)),
        Player(PlayerType.player1, Location(3, 6)),
        Player(PlayerType.player2, Location(9, 6))
      ],
    );
  }

  void restart() {
    pieces[0] = BallPiece(PlayerType.ball, Location(6, 6));
    pieces[1] = Player(PlayerType.player1, Location(3, 6));
    pieces[2] = Player(PlayerType.player2, Location(9, 6));
    currentBallTurn = null;
  }
}
