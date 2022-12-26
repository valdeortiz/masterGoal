import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mastergoal/audio.dart';
import 'package:mastergoal/clock/providers/coubtdown_provider.dart';
import 'package:mastergoal/constanst.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:mastergoal/pieces/ball.dart';
import 'package:mastergoal/pieces/mg_pieces.dart';
import 'package:mastergoal/pieces/player.dart';
import 'package:mastergoal/widgets/generic_dialog.dart';
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
    final game = Provider.of<GameCoordProvider>(context);
    final audio = Provider.of<AudioProvider>(context);

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
                    // "Turno: ${context.select((GameCoordProvider gamePro) => gamePro.currentTurn.name)}")
                    "Turno: ${context.select((GameCoordProvider gamePro) => gamePro.turnoActual)}",
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 40),
                    child: IconButton(
                        onPressed: () {
                          audio.playPause();
                        },
                        icon: Icon(
                          !context.select(
                                  (AudioProvider audiop) => audiop.isPlay)
                              ? Icons.play_circle_outline
                              : Icons.pause_circle_outlined,
                          size: 40,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 40),
                    child: IconButton(
                        onPressed: () {
                          // bool modifyMinute = false;
                          clockProvider.startStopTimer();
                          GenericDialog dialog = GenericDialog(
                            onPressed: () {},
                            onReject: () {
                              clockProvider.startStopTimer();
                              Navigator.of(context).pop();
                            },
                            titulo: "Pausa",
                            iosv: 2,
                            oneButton: true,
                          );

                          dialog.show(
                              context,
                              Builder(
                                builder: (context) => Column(
                                  children: [
                                    const Text(
                                      "Selecciona el tiempo",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            clockProvider.setCountdownDuration(
                                                const Duration(minutes: 10));
                                          },
                                          child: const Text("10 min"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            clockProvider.setCountdownDuration(
                                                const Duration(minutes: 15));
                                          },
                                          child: const Text("15 min"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            clockProvider.setCountdownDuration(
                                                const Duration(minutes: 20));
                                          },
                                          child: const Text("20 min"),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        audio.stop();
                                      },
                                      child: context.select(
                                              (AudioProvider audiop) =>
                                                  audiop.isStop)
                                          ? const Text("Activar audio")
                                          : const Text("Desactivar audio"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        game.newGame();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Reiniciar juego"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigator.of(context).repl
                                        Navigator.of(context).pop();
                                      },
                                      child:
                                          const Text("Volver a menu principal"),
                                    ),
                                  ],
                                ),
                              ));
                        },
                        icon: const Icon(
                          Icons.menu_open_outlined,
                          size: 40,
                        )),
                  )
                ],
              ),
              Expanded(
                  child: BoardWidget(
                clockProvider: clockProvider,
                gamePro: game,
                audioPro: audio,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class BoardWidget extends StatefulWidget {
  const BoardWidget(
      {super.key, this.clockProvider, this.gamePro, this.audioPro});
  final CountdownProvider? clockProvider;
  final GameCoordProvider? gamePro;
  final AudioProvider? audioPro;
  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late final double tileWidth =
      MediaQuery.of(context).size.width / Constantes.columnas;

  // final GameCoordinator coordinator = GameCoordinator.newGame();
  late GameCoordProvider? coordinator;

  // List<MgPiece> get pieces => coordinator.pieces;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    widget.audioPro?.iniciarAudio();
    coordinator = widget.gamePro;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.clockProvider?.startStopTimer();
      coordinator?.newGame();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // coordinator = Provider.of<GameCoordProvider>(context, listen: false);
    // coordinator?.newGame();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    widget.clockProvider?.cancelTimer();
    // coordinator?.newGame();
    // Provider.of<GameCoordProvider>(context, listen: false).newGame();
    widget.audioPro?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool isExit = false;
        GenericDialog d = GenericDialog(onPressed: () {
          isExit = true;
          Provider.of<GameCoordProvider>(context, listen: false).newGame();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }, onReject: () {
          Navigator.of(context).pop();
        });
        d.show(
            context,
            Column(
              children: const [Text("Desea salir y resetear la partida")],
            ));
        return !isExit;
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
          ],
        ),
      ),
    );
  }

  DragTarget buildDragTarget(int columna, int fila) {
    return DragTarget<MgPiece>(onAccept: (piece) {
      onAcept(piece, columna, fila);
      // En caso de jugar, jugador vs jugador comentar el future
    }, onWillAccept: (piece) {
      // if ((widget.clockProvider?.isWin ?? false) ||
      //     Provider.of<GameCoordProvider>(context, listen: false).isWin) {
      //   Navigator.of(context).pushReplacementNamed(FinalGameScreen.path);
      //   return false;
      // }
      if (piece == null) {
        return false;
      }
      if (piece.name == PlayerType.player2.name &&
          coordinator!.gameType == GameType.pc) {
        // Esperamos a que la pc juegue
        return false;
      }
      if (coordinator!.currentBallTurn == null &&
          Provider.of<GameCoordProvider>(context, listen: false).currentTurn !=
              piece.pieceType) {
        return false;
      }

      print(" $columna, $fila");
      print("OnWill: $piece");

      return piece.canMoveTo(columna, fila) &&
          !coordinator!.pieces
              .any((piece) => piece.location == Location(columna, fila));
      // coordinator!.pieceOfTile(columna, fila),
      // coordinator!.onPosesion(columna, fila));
    }, builder: (context, candidateData, rejectedData) {
      // print("candidate $candidateData, rejec: $rejectedData");
      // final piece = coordinator!.pieceOfTile(x, y);
      late bool pieceMove;
      if (candidateData.isNotEmpty) {
        pieceMove = candidateData[0]
                ?.canMoveTo(candidateData[0]!.x, candidateData[0]!.y) ??
            false;
      } else {
        pieceMove = false;
      }
      // print(pieceMove);
      return Container(
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: pieceMove ? Colors.lightGreen : Colors.lightGreen[700],
          border: buildBorder(columna, fila),
          // borderRadius: columna == (Constantes.columnas / 2) - 1 &&
          //         fila == (Constantes.filas / 2) - 1
          //     ? const BorderRadius.all(Radius.circular(20))
          //     : null,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: buildTextCell(columna, fila),
      );
    });
  }

  Location moverPC() {
    // En caso de que el jugador quede cerca de la pelota, colocar un future con el movimiento de la pelota
    coordinator!.pieces[2].movesPosible =
        coordinator!.pieces[2].moves(coordinator!.pieces);
    final randon = Random();
    return coordinator!.pieces[2].movesPosible[
        randon.nextInt(coordinator!.pieces[2].movesPosible.length)];
  }

  List moverPelota() {
    return [4, 2];
  }

  onAcept(MgPiece piece, columna, fila) {
    late bool habilitBall;
    coordinator?.pieces[1].movesPosible = coordinator!.pieces[1]
        .moves(Provider.of<GameCoordProvider>(context, listen: false).pieces);
    // seteamos la nueva posicion de la ficha
    piece.location = Location(columna, fila);
    piece.movesPosible = piece
        .moves(Provider.of<GameCoordProvider>(context, listen: false).pieces);

    if (piece is BallPiece) {
      coordinator?.currentBallTurn = null;
      final isGol = piece.isGol(
          Provider.of<GameCoordProvider>(context, listen: false).currentTurn,
          columna,
          fila);
      if (isGol) {
        Provider.of<GameCoordProvider>(context, listen: false).setGol();
        coordinator?.restart();
      } else {
        Provider.of<GameCoordProvider>(context, listen: false).changeTurn();
        if (coordinator!.gameType == GameType.pc &&
            Provider.of<GameCoordProvider>(context, listen: false)
                    .currentTurn ==
                PlayerType.player2) {
          Future.delayed(const Duration(seconds: 2), () {
            final data = moverPC();
            onAcept(
              Provider.of<GameCoordProvider>(context, listen: false).pieces[2],
              data.x,
              data.y,
            );
          });
        }
      }
      if (mounted) {
        setState(() {});
      }
      return;
    }
    habilitBall = piece is Player
        ? piece.enableBall(coordinator!.pieces[0].location)
        : false;

    coordinator!.currentBallTurn = habilitBall ? piece.pieceType : null;

    if (!habilitBall) {
      Provider.of<GameCoordProvider>(context, listen: false).changeTurn();
      // Si es modo de juego contra la pc, y el turno era del player 1
      // Mandamos a jugar a la maquina al camviar el turno
      if (coordinator!.gameType == GameType.pc &&
          piece.pieceType == PlayerType.player1) {
        Future.delayed(const Duration(seconds: 2), () {
          final data = moverPC();
          onAcept(
            Provider.of<GameCoordProvider>(context, listen: false).pieces[2],
            data.x,
            data.y,
          );
        });
      }
    }

    // verificamos que el tipo de juego sea contra pc, que tenga habilitado la pelota y el jugador sea 2
    // en caso de que sea TRUE todas, se juega automatico simulando una pc
    if (coordinator!.gameType == GameType.pc &&
        habilitBall &&
        piece.pieceType == PlayerType.player2) {
      final data = moverPelota();
      Future.delayed(
          const Duration(seconds: 1),
          () => onAcept(
                Provider.of<GameCoordProvider>(context, listen: false)
                    .pieces[0],
                data[0],
                data[1],
              ));
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildTextCell(int x, int y) {
    final piece = coordinator!.pieceOfTile(x, y);
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

    if (x == (Constantes.columnas - 1) / 2 && y == (Constantes.filas - 1) / 2) {
      return Border.all(
        color: Colors.white,
        width: 1.5,
      );
    }

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
