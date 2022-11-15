import 'package:collection/collection.dart';
import 'package:mastergoal/pieces/bishop.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';

class GameCoordinator {
  final List<MgPiece> pieces;

  PlayerColor currentTurn = PlayerColor.white;

  GameCoordinator(this.pieces);

  MgPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);

  factory GameCoordinator.newGame() {
    return GameCoordinator(
      [
        Bishop(PlayerColor.white, Location(6, 5)),
        Bishop(PlayerColor.black, Location(6, 7)),
        // Bishop(PlayerColor.white, Location(5, 0)),
        // Bishop(PlayerColor.black, Location(2, 7)),
        // Bishop(PlayerColor.black, Location(5, 7)),
      ],
    );
  }
}
