import 'package:flutter/material.dart';
import 'package:mastergoal/widgets/generic_dialog.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});
  static const tutorialScreenPath = '/tutorial';
  static const numberCell = 13;
  // static const numberCellY = 13;
  // static const numeroFilas = 13;
  static const numeroColumnas = 13;

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final List<String> mensajes = [
    'Bienvenido a MASTERGOAL, el juego es un partido de futbol transladado a un tablero',
    'El tablero es de 13x11 que representa a la cancha, las casillas con puntos son las especiales',
    // 'Tablero',
    'El juego consiste en meter goles, es decir, hacer llegar la ficha de la pelota hasta las casillas que sobresalen del extremo',
    // 'Casillas del arco',
    'El nivel 1 involucra a dos jugadores, uno por equipo. Al inicio de la partida cada jugador se encuentra en su area a 2 casillas de la pelota, que se encuentra en el centro de la cancha'
        // 'Jugadores',
        'Al iniciar la pelota se encutra en el centro de la cancha',
    // 'Pelota',
    'El flujo del juego se da por turnos intercalados entre jugadores. En cada turno se mueve mover la ficha del jugador y del balon',
    'En su turno el jugador puede moverse 1 o 2 casillas en linea recta, en cualquier direccion',
    // 'Movimientos del jugador',
    'Para mover la pelota, el jugador debe moverse a una casilla contigua a la pelota',
    // 'Casillas de posesion',
    'De esta manera el jugador toma posesion de la pelota y puede moverla, la pelota se puede mover hasta 4 casillas de distancia en linea recta , hacia cualquier direccion',
    // 'Movimiento de la pelota',
    // 'Un jugador no puede dejar la pelota dentro de su propia area o en el corner propio y tampoco puede entregarsela a un jugador contrario',
    // 'Area del jugador 1',
    // 'Corner del jugador 1',
    // 'Area de posicion del jugador 2',
    // 'Area del juego',
    // 'La pelota puede saltar a los jugadores',
    'Felicidades por completar el tutorial, ahora estas listo/a para disfruta !'
  ];
  // final List<String> titulos = ['Jugadores', 'que', 'tal'];
  String mensaje = '';
  int indice = 0;
  void _showDialog(context) {
    final GenericDialog ge = GenericDialog(
        opcion2: "Cerrar",
        opcion1: "Siguiente",
        // titulo: titulos[indice],
        titulo: "TUTORIAL",
        onPressed: () {
          Navigator.of(context).pop();
          if (indice < mensajes.length - 1) {
            indice++;
            mensaje = mensajes[indice];
            // setState(() {
            // });
            _showDialog(context);
          }
        },
        onReject: () {
          Navigator.of(context).pop();
        });
    ge.show(context, Text(mensaje));
  }

  @override
  void initState() {
    super.initState();
    mensaje = mensajes[0];
    WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog(context));
    // WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen =
        (MediaQuery.of(context).size.width - 40) / TutorialScreen.numberCell;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/madera.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            TableroPuntuacion(sizeScreen: sizeScreen),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buildBoard(sizeScreen),
            ),
          ],
        ),
      ),
    );
  }

  Column buildBoard(double sizeScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          TutorialScreen.numberCell,
          (fila) => Row(
            children: [
              ...List.generate(
                TutorialScreen.numeroColumnas,
                (columna) => Container(
                  decoration: BoxDecoration(
                      // color: buildColor(x, y),
                      color: Colors.lightGreen[700],
                      // color: const Color(0xFF79D56F),
                      border: buildBorder(columna, fila)),
                  height: sizeScreen,
                  width: sizeScreen,
                  child: buildTextCell(columna, fila),
                ),
              )
            ],
          ),
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        // Row(
        //   // crossAxisAlignment: CrossAxisAlignment.end,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     MaterialButton(onPressed: () {}, child: const Text("Atras")),
        //     MaterialButton(
        //       onPressed: () {},
        //       child: const Text("Siguiente"),
        //     )
        //   ],
        // ),
      ],
    );
  }

  Widget buildTextCell(int x, int y) {
    if (x == (TutorialScreen.numberCell - 1) / 2 &&
        y == (TutorialScreen.numberCell - 1) / 2) {
      // if (x == 6 && y == 6) {
      return Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/ball.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    if (x == ((TutorialScreen.numberCell - 1) / 2) - 1 &&
        y == ((TutorialScreen.numberCell - 1) / 2)) {
      // if (x == 6 && y == 6) {
      return Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/player.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    if (x == ((TutorialScreen.numberCell - 1) / 2) + 1 &&
        y == ((TutorialScreen.numberCell - 1) / 2)) {
      // if (x == 6 && y == 6) {
      return Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/player.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
    if ((x == TutorialScreen.numberCell - 1 &&
            y == TutorialScreen.numberCell - 1) ||
        (x == 0 && y == 0) ||
        (x == 0 && y == TutorialScreen.numberCell - 1) ||
        (x == TutorialScreen.numberCell - 1 && y == 0)) {
      return const Text(
        '◉',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    }
    if ((x == TutorialScreen.numberCell - 1 || x == 0) &&
        (y < TutorialScreen.numberCell / 2 + 3 && y > 2)) {
      return const Text(
        '◉',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    }
    return const Text(
      '',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Border buildBorder(int x, int y) {
    const int areaGrande = 4;
    const int areaChica = 2;
    const int yAreaGrande = 1;
    const int yAreaChica = 3;

    if (x == TutorialScreen.numberCell - 1 &&
        y == TutorialScreen.numberCell - 1) {
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
    if (x == 0 && y == TutorialScreen.numberCell - 1) {
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
    if (x == TutorialScreen.numberCell - 1 && y == 0) {
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
      case TutorialScreen.numberCell - 1:
        return Border(
          right: const BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color:
                y == yAreaChica || y == TutorialScreen.numberCell - yAreaChica
                    ? Colors.white
                    : Colors.grey,
          ),
          bottom: const BorderSide(
            color: Colors.grey,
          ),
        );
      case TutorialScreen.numberCell - areaGrande:
        return Border(
          left: BorderSide(
            color: y < TutorialScreen.numberCell - 1 && y > 0
                ? Colors.white
                : Colors.grey,
          ),
          top: BorderSide(
            color: y == 0 || y == TutorialScreen.numberCell - 1
                ? Colors.white
                : Colors.grey,
          ),
          bottom: BorderSide(
            color: y == TutorialScreen.numberCell - 1 || y == 0
                ? Colors.white
                : Colors.grey,
          ),
        );
      case 0 + areaGrande:
        return Border(
          left: BorderSide(
              color: y == 0 || y == TutorialScreen.numberCell - 1
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(color: y > 0 ? Colors.grey : Colors.white),
          bottom: BorderSide(
            color:
                y == TutorialScreen.numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case 0:
        return Border(
          left: BorderSide(
              color: y == 0 || y == TutorialScreen.numberCell - 1
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color:
                  y == TutorialScreen.numberCell - yAreaChica || y == yAreaChica
                      ? Colors.white
                      : Colors.grey),
          bottom: BorderSide(
            color: y == 0 || y == TutorialScreen.numberCell - 1
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
              color: y >= 0 && y < 3 || y > TutorialScreen.numberCell - 4
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: (y == 0 || y == 1 || y == TutorialScreen.numberCell - 1)
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color:
                y == TutorialScreen.numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case TutorialScreen.numberCell - areaChica:
        return Border(
          left: BorderSide(
              color: y >= 0 && y < 3 || y > TutorialScreen.numberCell - 4
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: (y < 2 ||
                      y == TutorialScreen.numberCell - 1 ||
                      y == TutorialScreen.numberCell - yAreaChica ||
                      y == yAreaChica)
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color:
                y == TutorialScreen.numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      // default:
      //   return const Border(left: BorderSide(color: Colors.grey));
    }
    switch (y) {
      case TutorialScreen.numberCell - 1:
        return Border(
          bottom: const BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: x > areaGrande && x < TutorialScreen.numberCell - areaGrande
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
            color: x > areaGrande && x < TutorialScreen.numberCell - areaGrande
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
      case TutorialScreen.numberCell - yAreaChica:
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

class TableroPuntuacion extends StatelessWidget {
  const TableroPuntuacion({
    Key? key,
    required this.sizeScreen,
  }) : super(key: key);

  final double sizeScreen;
  final TextStyle _style =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                height: sizeScreen,
                // width: sizeScreen,
                alignment: Alignment.center,
                child: Text(
                  "Home",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border(
                    left: BorderSide(
                      //                   <--- left side
                      // color: Colors.black,
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ),
                height: sizeScreen,
                width: sizeScreen,
                alignment: Alignment.center,
                child: Text(
                  "0",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border(
                    left: BorderSide(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    right: BorderSide(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ),
                height: sizeScreen,
                width: sizeScreen,
                alignment: Alignment.center,
                child: Text(
                  "0",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                height: sizeScreen,
                // width: sizeScreen,
                alignment: Alignment.center,
                child: Text(
                  "Away",
                  textAlign: TextAlign.center,
                  style: _style,
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Turno: Jugador 1",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.left,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "00:00",
              style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}

Color buildColor(int x, int y) {
  int value = x;
  if (y.isEven) {
    value++;
  }
  return value.isEven ? Colors.green : Colors.greenAccent;
}
