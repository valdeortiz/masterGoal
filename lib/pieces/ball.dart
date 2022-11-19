import 'package:mastergoal/pieces/mg_pieces.dart';

class BallPiece extends MgPiece {
  BallPiece(super.pieceType, super.location);

  @override
  List<Location> moves(List<MgPiece> others) {
    // TODO: implement moves
    throw UnimplementedError();
  }

  @override
  // TODO: implement name
  String get name => 'ball';

  @override
  bool canMoveTo(int x, int y) {
    // TODO: implement canMoveTo
    throw UnimplementedError();
  }
}
