import 'mg_pieces.dart';

class Bishop extends MgPiece {
  @override
  String get name => pieceType.name;
  int _gols = 0;
  int get gols => _gols;
  marcarGol() => _gols += 1;

  Bishop(
    PlayerType pieceType,
    Location location,
  ) : super(pieceType, location);

  @override
  List<Location> moves(List<MgPiece> others) {
    return <Location>[
      ..._generateMovesOnDiagonal(true, true, others),
      ..._generateMovesOnDiagonal(false, true, others),
      ..._generateMovesOnDiagonal(true, false, others),
      ..._generateMovesOnDiagonal(false, false, others),
    ].toList();
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
}
