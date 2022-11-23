import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mastergoal/clock/providers/coubtdown_provider.dart';
import 'package:mastergoal/constanst.dart';
import 'package:mastergoal/game_coordinator.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';
import 'package:mastergoal/pieces/player.dart';
import 'package:mastergoal/widgets/tablero_widget.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatelessWidget {
  static const playScreenPath = '/play';

  const PlayScreen({super.key});
  // @override
  // void initState() {
  //   super.initState();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  // }

  @override
  Widget build(BuildContext context) {
    final clockProvider = Provider.of<CountdownProvider>(context);
    // final game = Provider.of<GameCoordProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/madera.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const TableroPuntuacion(),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    context.select((CountdownProvider countdown) =>
                        countdown.timeLeftString),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      "Turno: ${context.select((GameCoordProvider gamePro) => gamePro.currentTurn.name)}")
                ],
              ),
              Expanded(
                  child: BoardWidget(
                clockProvider: clockProvider,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key, this.clockProvider});
  final CountdownProvider? clockProvider;
  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late final double tileWidth =
      MediaQuery.of(context).size.width / Constantes.columnas;

  final GameCoordinator coordinator = GameCoordinator.newGame();

  List<MgPiece> get pieces => coordinator.pieces;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.clockProvider?.startStopTimer());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
          Constantes.filas,
          (fila) => Expanded(
            child: Row(
              children: [
                ...List.generate(
                  Constantes.columnas,
                  (columna) => Expanded(
                    child: buildDragTarget(columna, fila),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  DragTarget buildDragTarget(int columna, int fila) {
    return DragTarget<MgPiece>(
      onAccept: (piece) {
        print("OnAcep: $piece");
        // final move = piece.move();
        // logica del reloj, pongo a 20 seg e inicio
        widget.clockProvider?.setCountdownDuration(const Duration(seconds: 20));
        widget.clockProvider?.startStopTimer();
        // esta variable verifica si esta habilitado a mover la pelota
        late bool habilitBall;
        // seteamos la nueva posicion de la ficha
        piece.location = Location(columna, fila);

        if (piece is BallPiece) {
          coordinator.currentBallTurn = null;
          final isGol = piece.isGol(
              Provider.of<GameCoordProvider>(context, listen: false)
                  .currentTurn,
              columna,
              fila);
          if (isGol) {
            Provider.of<GameCoordProvider>(context, listen: false).setGol();
            coordinator.restart();
          } else {
            Provider.of<GameCoordProvider>(context, listen: false).changeTurn();
          }

          setState(() {});
          return;
        }
        habilitBall = piece is Player
            ? piece.enableBall(coordinator.pieces[0].location)
            : false;

        coordinator.currentBallTurn = habilitBall ? piece.pieceType : null;

        if (!habilitBall) {
          Provider.of<GameCoordProvider>(context, listen: false).changeTurn();
        }

        setState(() {});
      },
      onWillAccept: (piece) {
        if (piece == null) {
          return false;
        }
        if (coordinator.currentBallTurn == null &&
            Provider.of<GameCoordProvider>(context, listen: false)
                    .currentTurn !=
                piece.pieceType) {
          return false;
        }

        print(" $columna, $fila");
        print("OnWill: $piece");
        return piece.canMoveTo(
            columna,
            fila,
            coordinator.pieceOfTile(columna, fila),
            coordinator.onPosesion(columna, fila));
      },
      builder: (context, candidateData, rejectedData) => Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen[700],
          border: buildBorder(columna, fila),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: buildTextCell(columna, fila),
      ),
    );
  }

  Widget buildTextCell(int x, int y) {
    final piece = coordinator.pieceOfTile(x, y);
    if (piece != null) {
      return assetPaint(piece, x, y);
    }
    const texto = Text(
      '◉',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
      ),
    );

    if ((x == Constantes.columnas - 1 && y == Constantes.columnas - 1) ||
        (x == 0 && y == 0) ||
        (x == 0 && y == Constantes.columnas - 1) ||
        (x == Constantes.columnas - 1 && y == 0)) {
      return texto;
    }
    if ((x == Constantes.columnas - 1 || x == 0) &&
        (y < Constantes.columnas / 2 + 3 && y > 2)) {
      return texto;
    }
    return const Text(
      '',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  assetPaint(MgPiece piece, x, y) {
    final child = Container(
      alignment: Alignment.center,
      child: Image.asset(
        piece.fileName,
        height: MediaQuery.of(context).size.height * 0.8 / Constantes.columnas,
        width: MediaQuery.of(context).size.width * 0.8 / Constantes.columnas,
      ),
    );
    return Draggable(
      data: piece,
      feedback: child,
      childWhenDragging: Container(color: Colors.lightGreen),
      child: child,
    );
  }

  Border buildBorder(int x, int y) {
    const int areaGrande = 4;
    const int areaChica = 2;
    const int yAreaGrande = 1;
    const int yAreaChica = 3;

    if (x == Constantes.columnas - 1 && y == Constantes.columnas - 1) {
      return const Border(
        right: BorderSide(
          color: Colors.white,
        ),
        bottom: BorderSide(
          color: Colors.white,
        ),
        top: BorderSide(
          color: Colors.white,
        ),
        left: BorderSide(
          color: Colors.grey,
        ),
      );
    }
    if (x == 0 && y == Constantes.columnas - 1) {
      return const Border(
        left: BorderSide(
          color: Colors.white,
        ),
        bottom: BorderSide(
          color: Colors.white,
        ),
        top: BorderSide(
          color: Colors.white,
        ),
        right: BorderSide(
          color: Colors.grey,
        ),
      );
    }
    if (x == Constantes.columnas - 1 && y == 0) {
      return const Border(
        right: BorderSide(
          color: Colors.white,
        ),
        top: BorderSide(
          color: Colors.white,
        ),
        bottom: BorderSide(
          color: Colors.white,
        ),
        left: BorderSide(
          color: Colors.grey,
        ),
      );
    }
    if (x == 0 && y == 0) {
      return const Border(
        left: BorderSide(
          color: Colors.white,
        ),
        top: BorderSide(
          color: Colors.white,
        ),
        bottom: BorderSide(
          color: Colors.white,
        ),
        right: BorderSide(
          color: Colors.grey,
        ),
      );
    }

    switch (x) {
      case Constantes.columnas - 1:
        return Border(
          right: const BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: y == yAreaChica || y == Constantes.columnas - yAreaChica
                ? Colors.white
                : Colors.grey,
          ),
          bottom: const BorderSide(
            color: Colors.grey,
          ),
        );
      case Constantes.columnas - areaGrande:
        return Border(
          left: BorderSide(
            color: y < Constantes.columnas - 1 && y > 0
                ? Colors.white
                : Colors.grey,
          ),
          top: BorderSide(
            color: y == 0 || y == Constantes.columnas - 1
                ? Colors.white
                : Colors.grey,
          ),
          bottom: BorderSide(
            color: y == Constantes.columnas - 1 || y == 0
                ? Colors.white
                : Colors.grey,
          ),
        );
      case 0 + areaGrande:
        return Border(
          left: BorderSide(
              color: y == 0 || y == Constantes.columnas - 1
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(color: y > 0 ? Colors.grey : Colors.white),
          bottom: BorderSide(
            color: y == Constantes.columnas - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case 0:
        return Border(
          left: BorderSide(
              color: y == 0 || y == Constantes.columnas - 1
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: y == Constantes.columnas - yAreaChica || y == yAreaChica
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color: y == 0 || y == Constantes.columnas - 1
                ? Colors.white
                : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case areaChica:
        return Border(
          left: BorderSide(
              color: y >= 0 && y < 3 || y > Constantes.columnas - 4
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: (y == 0 || y == 1 || y == Constantes.columnas - 1)
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color: y == Constantes.columnas - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case Constantes.columnas - areaChica:
        return Border(
          left: BorderSide(
              color: y >= 0 && y < 3 || y > Constantes.columnas - 4
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: (y < 2 ||
                      y == Constantes.columnas - 1 ||
                      y == Constantes.columnas - yAreaChica ||
                      y == yAreaChica)
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color: y == Constantes.columnas - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      // default:
      //   return const Border(left: BorderSide(color: Colors.grey));
    }
    switch (y) {
      case Constantes.columnas - 1:
        return Border(
          bottom: const BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: x > areaGrande && x < Constantes.columnas - areaGrande
                ? Colors.grey
                : Colors.white,
          ),
          left: const BorderSide(
            color: Colors.grey,
          ),
        );
      // case numberCell - 2:
      //   return Border(
      //     bottom: BorderSide(
      //       color: x > areaGrande ? Colors.grey : Colors.white,
      //     ),
      //     top: const BorderSide(
      //       color: Colors.grey,
      //     ),
      //     left: const BorderSide(
      //       color: Colors.grey,
      //     ),
      //   );
      case 0:
        return Border(
          top: const BorderSide(color: Colors.white),
          bottom: BorderSide(
            color: x > areaGrande && x < Constantes.columnas - areaGrande
                ? Colors.grey
                : Colors.white,
          ),
          left: const BorderSide(
            color: Colors.grey,
          ),
        );
      case yAreaChica:
        return Border(
          left: const BorderSide(color: Colors.grey),
          top: BorderSide(color: x < areaChica ? Colors.white : Colors.grey),
          bottom: const BorderSide(
            color: Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case Constantes.columnas - yAreaChica:
        return Border(
          left: const BorderSide(color: Colors.grey),
          top: BorderSide(color: x < areaChica ? Colors.white : Colors.grey),
          bottom: const BorderSide(
            color: Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
    }

    return Border.all(color: Colors.grey);
    // return Border.all(
    //     color: (x == numberCell - 1 || y == numberCell - 1 || x == 0 || y == 0)
    //         ? Colors.white
    //         : Colors.grey);
  }
}
