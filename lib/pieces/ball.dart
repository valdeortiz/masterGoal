import 'package:mastergoal/constanst.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';

class BallPiece extends MgPiece {
  BallPiece(super.pieceType, super.location, super.movesPosible);
  final List<Location> golsPlayer2Square = [
    Location(0, 3),
    Location(0, 4),
    Location(0, 5),
    Location(0, 6),
    Location(0, 7),
    Location(0, 8),
    Location(0, 9),
  ];
  final List<Location> golsPlayer1Square = [
    Location(Constantes.columnas - 1, 3),
    Location(Constantes.columnas - 1, 4),
    Location(Constantes.columnas - 1, 5),
    Location(Constantes.columnas - 1, 6),
    Location(Constantes.columnas - 1, 7),
    Location(Constantes.columnas - 1, 8),
    Location(Constantes.columnas - 1, 9)
  ];

  @override
  List<Location> moves(List<MgPiece> others) {
    // La pelota se mueve hasta 4 casillas en linea recta
    // la pelota ademas salta sobre los jugadores
    // la pelota no debe quedar en manos de ningun jugador
    // la pelota no puede quedar en el area del jugador que posee la pelota
    // la pelota no se puede dejar a un jugador contrario
    return <Location>[
      ..._generateMoves(x - 1, y - 1, others),
      ..._generateMoves(x - 1, y, others),
      ..._generateMoves(x - 1, y + 1, others),
      Location(x - 2, y),
      Location(x + 2, y),
      Location(x, y + 2),
      Location(x, y - 2),
    ].toList();
  }

  bool isGol(PlayerType type, int x, int y) {
    switch (type) {
      case PlayerType.player1:
        return golsPlayer1Square.contains(Location(x, y));
      case PlayerType.player2:
        return golsPlayer2Square.contains(Location(x, y));
      default:
        return false;
    }
  }

  List<Location> _generateMoves(
    int x,
    int y,
    List<MgPiece> pieces,
  ) {
    bool obstructed = false;

    final a = List<Location?>.generate(3, (i) {
      if (obstructed) return null;

      // int dx = (isRight ? 1 : -1) * i;
      // int dy = (isUp ? 1 : -1) * i;

      final destination = Location(x + i, y);

      final pieceOnLocation =
          pieces.any((piece) => piece.location == destination);

      if (pieceOnLocation && location != destination) {
        obstructed = true;
        return null;
      }

      return destination;
    }).whereType<Location>().where((location) => location.isValid).toList();
    print(a);
    return a;
  }

  @override
  String get name => 'ball';

  // @override
  // bool canMoveTo(int x, int y, MgPiece? piece, bool posesion) {
  //   if (piece != null) return false;
  //   if (posesion == false) return false;
  //   if (((abs(x - this.x) <= 4) && (this.y == y)) ||
  //       ((abs(y - this.y) <= 4) && (this.x == x)) ||
  //       ((abs(y - this.y) == abs(x - this.x)) && (abs(x - this.x) <= 4))) {
  //     return true;
  //   }
  //   return false;
  // }

  abs(int value) {
    return value < 0 ? -value : value;
  }
}
