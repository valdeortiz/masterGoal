import 'mg_pieces.dart';

class Player extends MgPiece {
  @override
  String get name => pieceType.name;

  Player(
    PlayerType pieceType,
    Location location,
  ) : super(pieceType, location);

  enableBall(Location ballLocation) {
    print("bh $ballLocation");
    print("h $location");
    // La pieza debe estar en una posicion adyacente a la pos de la pelota
    if ((abs(x - ballLocation.x) <= 1 && abs(y - ballLocation.y) <= 1) ||
        (y == ballLocation.y && abs(ballLocation.x - x) <= 1) ||
        x == ballLocation.x && abs(ballLocation.y - y) <= 1) {
      return true;
    }
    return false;
  }

  @override
  List<Location> moves(List<MgPiece> others) {
    // return <Location>[
    //   ..._generateMovesOnDiagonal(true, true, others),
    //   ..._generateMovesOnDiagonal(false, true, others),
    //   ..._generateMovesOnDiagonal(true, false, others),
    //   ..._generateMovesOnDiagonal(false, false, others),
    // ].toList();
    return [];
  }

  List<Location> _generateMovesOnDiagonal(
    bool isUp,
    bool isRight,
    List<MgPiece> pieces,
  ) {
    bool obstructed = false;

    return List<Location?>.generate(8, (i) {
      if (obstructed) return null;

      int dx = (isRight ? 1 : -1) * i;
      int dy = (isUp ? 1 : -1) * i;

      final destination = Location(x + dx, y + dy);

      final pieceOnLocation =
          pieces.any((piece) => piece.location == destination);

      if (pieceOnLocation && location != destination) {
        obstructed = true;
        return null;
      }

      return destination;
    }).whereType<Location>().where((location) => location.isValid).toList();
  }

  @override
  bool canMoveTo(int x, int y, MgPiece? piece) {
    // Todo jugador puede moverse= hasta dos casillas en linea recta
    if (piece != null) return false;
    if (((abs(x - this.x) <= 2) && (this.y == y)) ||
        ((abs(y - this.y) <= 2) && (this.x == x)) ||
        ((abs(y - this.y) == abs(x - this.x)) && (abs(x - this.x) <= 2))) {
      return true;
    }
    return false;
  }

  abs(int value) {
    return value < 0 ? -value : value;
  }
}
