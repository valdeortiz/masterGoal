import 'package:flutter/material.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});
  static const tutorialScreenPath = '/tutorial';
  static const numberCell = 13;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = (MediaQuery.of(context).size.width - 40) / numberCell;
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
            numberCell,
            (y) => Row(
                  children: [
                    ...List.generate(
                      numberCell,
                      (x) => Container(
                        decoration: BoxDecoration(
                            // color: buildColor(x, y),
                            color: Colors.green,
                            border: buildBorder(x, y)),
                        height: sizeScreen,
                        width: sizeScreen,
                        child: const Text(""),
                      ),
                    )
                  ],
                ))
      ],
    );
  }

  Border buildBorder(int x, int y) {
    const int areaGrande = 4;
    const int areaChica = 2;
    const int yAreaGrande = 1;
    const int yAreaChica = 3;

    if (x == numberCell - 1 && y == numberCell - 1) {
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
    if (x == 0 && y == numberCell - 1) {
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
    if (x == numberCell - 1 && y == 0) {
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
      case numberCell - 1:
        return Border(
          right: const BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: y == yAreaChica || y == numberCell - yAreaChica
                ? Colors.white
                : Colors.grey,
          ),
          bottom: const BorderSide(
            color: Colors.grey,
          ),
        );
      case numberCell - areaGrande:
        return Border(
          left: BorderSide(
            color: y < numberCell - 1 && y > 0 ? Colors.white : Colors.grey,
          ),
          top: BorderSide(
            color: y == 0 || y == numberCell - 1 ? Colors.white : Colors.grey,
          ),
          bottom: BorderSide(
            color: y == numberCell - 1 || y == 0 ? Colors.white : Colors.grey,
          ),
        );
      case 0 + areaGrande:
        return Border(
          left: BorderSide(
              color:
                  y == 0 || y == numberCell - 1 ? Colors.grey : Colors.white),
          top: BorderSide(color: y > 0 ? Colors.grey : Colors.white),
          bottom: BorderSide(
            color: y == numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case 0:
        return Border(
          left: BorderSide(
              color:
                  y == 0 || y == numberCell - 1 ? Colors.grey : Colors.white),
          top: BorderSide(
              color: y == numberCell - yAreaChica || y == yAreaChica
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color: y == 0 || y == numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case areaChica:
        return Border(
          left: BorderSide(
              color: y >= 0 && y < 3 || y > numberCell - 4
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: (y == 0 || y == 1 || y == numberCell - 1)
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color: y == numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      case numberCell - areaChica:
        return Border(
          left: BorderSide(
              color: y >= 0 && y < 3 || y > numberCell - 4
                  ? Colors.grey
                  : Colors.white),
          top: BorderSide(
              color: (y < 2 ||
                      y == numberCell - 1 ||
                      y == numberCell - yAreaChica ||
                      y == yAreaChica)
                  ? Colors.white
                  : Colors.grey),
          bottom: BorderSide(
            color: y == numberCell - 1 ? Colors.white : Colors.grey,
          ),
          right: const BorderSide(
            color: Colors.grey,
          ),
        );
      // default:
      //   return const Border(left: BorderSide(color: Colors.grey));
    }
    switch (y) {
      case numberCell - 1:
        return Border(
          bottom: const BorderSide(
            color: Colors.white,
          ),
          top: BorderSide(
            color: x > areaGrande && x < numberCell - areaGrande
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
            color: x > areaGrande && x < numberCell - areaGrande
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
      case numberCell - yAreaChica:
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
  final TextStyle _style = const TextStyle(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            height: sizeScreen,
            width: sizeScreen,
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
            decoration: const BoxDecoration(color: Colors.blueAccent),
            height: sizeScreen,
            width: sizeScreen,
            alignment: Alignment.center,
            child: Text(
              "Away",
              textAlign: TextAlign.center,
              style: _style,
            ),
          ),
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
