import 'package:collection/collection.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/player.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';

class GameCoordinator {
  final List<MgPiece> pieces;

  PlayerType currentTurn = PlayerType.player1;
  PlayerType? currentBallTurn;

  GameCoordinator(this.pieces);

  MgPiece? pieceOfTile(int x, int y) =>
      pieces.firstWhereOrNull((p) => p.x == x && p.y == y);
  BallPiece ball = BallPiece(PlayerType.ball, Location(6, 6));

  factory GameCoordinator.newGame() {
    return GameCoordinator(
      [
        Player(PlayerType.player1, Location(5, 6)),
        Player(PlayerType.player2, Location(7, 6)),
      ],
    );
  }
}
