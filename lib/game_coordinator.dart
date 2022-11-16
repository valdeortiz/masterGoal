import 'package:collection/collection.dart';
import 'package:mastergoal/pieces/bishop.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';

class GameCoordinator {
  final List<MgPiece> pieces;

  PlayerType currentTurn = PlayerType.player1;

  GameCoordinator(this.pieces);

  MgPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);

  factory GameCoordinator.newGame() {
    return GameCoordinator(
      [
        Bishop(PlayerType.player1, Location(5, 6)),
        Bishop(PlayerType.ball, Location(6, 6)),
        Bishop(PlayerType.player2, Location(7, 6)),
      ],
    );
  }
}
