import 'package:mastergoal/constanst.dart';

enum PlayerType { player1, player2, ball }

class Location {
  final int x;
  final int y;

  Location(this.x, this.y);

  bool get isValid => x <= Constantes.filas - 1 && y <= Constantes.columnas - 1;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Location && (x == other.x && y == other.y);
  }

  @override
  String toString() => "Location($x, $y)";
}

abstract class MgPiece {
  final PlayerType pieceType;
  Location location;

  String get name;

  String get fileName => "assets/${pieceType.name}.png";

  int get x => location.x;

  int get y => location.y;

  MgPiece(
    this.pieceType,
    this.location,
  );

  List<Location> moves(List<MgPiece> others);

  // bool canMoveTo(int x, int y, List<MgPiece> others) =>
  //     moves(others).contains(Location(x, y));
  bool canMoveTo(int x, int y);
  @override
  String toString() => "$name($x, $y)";
}
