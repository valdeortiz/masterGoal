import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/audio.dart';
import 'package:mastergoal/clock/providers/coubtdown_provider.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:mastergoal/values/textStyle_app.dart';
import 'package:mastergoal/widgets/boton_siguiente.dart';
import 'package:provider/provider.dart';

class ConfiguracionScreen extends StatelessWidget {
  ConfiguracionScreen({super.key});
  static const path = '/config';
  final TextEditingController nombreJugador1 = TextEditingController(text: "");
  final TextEditingController nombreJugador2 = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: [
            Lottie.asset('assets/lottie/settings.json', height: 250),
            FittedBox(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Configuracion ",
                        style: textBase.copyWith(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: "Master Goal",
                      style: textBase.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: "El modo de juego es de ", style: textBase),
                TextSpan(
                  text: "Nivel 1",
                  style: textBase.copyWith(
                      color: Colors.green, fontWeight: FontWeight.bold),
                )
              ])),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Selecciona el tiempo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const BotonesTiempo(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Cantidad maxima de goles",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: context.select(
                              (GameCoordProvider game) => game.maxGols) ==
                          5
                      ? null
                      : () {
                          Provider.of<GameCoordProvider>(context, listen: false)
                              .changeMaxGol(5);
                        },
                  child: const Text("5 goles"),
                ),
                ElevatedButton(
                  onPressed: context.select(
                              (GameCoordProvider game) => game.maxGols) ==
                          10
                      ? null
                      : () {
                          Provider.of<GameCoordProvider>(context, listen: false)
                              .changeMaxGol(10);
                        },
                  child: const Text("10 goles"),
                ),
                ElevatedButton(
                  onPressed: context.select(
                              (GameCoordProvider game) => game.maxGols) ==
                          15
                      ? null
                      : () {
                          Provider.of<GameCoordProvider>(context, listen: false)
                              .changeMaxGol(15);
                        },
                  child: const Text("15 goles"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Selecciona el modo de juego",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: context.select(
                              (GameCoordProvider game) => game.gameType) ==
                          GameType.pc
                      ? null
                      : () {
                          Provider.of<GameCoordProvider>(context, listen: false)
                              .changeModeType();
                        },
                  child: const Text("Jugador VS PC"),
                ),
                ElevatedButton(
                  onPressed: context.select(
                              (GameCoordProvider game) => game.gameType) ==
                          GameType.jugador
                      ? null
                      : () {
                          Provider.of<GameCoordProvider>(context, listen: false)
                              .changeModeType();
                        },
                  child: const Text("Jugador VS Jugador"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                      child: TextField(
                        maxLength: 10,
                        controller: nombreJugador1,
                        decoration: const InputDecoration(
                          hintText: "Jugaddor 1",
                          // icon: Icon(Icons.account_circle_outlined),
                        ),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<GameCoordProvider>(context, listen: false)
                            .namePlayer1 = nombreJugador1.text;
                        // nombreJugador1.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "El nombre se modifico correctamente")));
                      },
                      child: const Text("Cambiar nombre")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      child: TextField(
                        maxLength: 10,
                        controller: nombreJugador2,
                        decoration: const InputDecoration(
                          hintText: "Jugaddor 2",
                          // icon: Icon(Icons.account_circle_outlined),
                        ),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<GameCoordProvider>(context, listen: false)
                            .namePlayer2 = nombreJugador2.text;
                        // nombreJugador2.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "El nombre se modifico correctamente")));
                      },
                      child: const Text("Cambiar nombre")),
                ],
              ),
            ),
            BotonSiguiente(
              onTap: () =>
                  Provider.of<AudioProvider>(context, listen: false).stop(),
              color: Colors.green,
              icono: context.select((AudioProvider audiop) => audiop.isStop)
                  ? Icons.music_note
                  : Icons.music_off,
              titulo: context.select((AudioProvider audiop) => audiop.isStop)
                  ? "Activar audio"
                  : "Desactivar audio",
            ),
            BotonSiguiente(
              titulo: "Volver al menu principal",
              onTap: () => Navigator.of(context).pop(),
              color: Colors.red,
              icono: Icons.exit_to_app,
            )
          ],
        ),
      ),
    );
  }
}

class BotonesTiempo extends StatefulWidget {
  const BotonesTiempo({
    Key? key,
  }) : super(key: key);

  @override
  State<BotonesTiempo> createState() => _BotonesTiempoState();
}

enum BotonesTiempoEnum { M, N, B, V }

class _BotonesTiempoState extends State<BotonesTiempo> {
  BotonesTiempoEnum botonActivo = BotonesTiempoEnum.M;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: botonActivo == BotonesTiempoEnum.M
                ? null
                : () {
                    botonActivo = BotonesTiempoEnum.M;
                    setState(() {});
                    Provider.of<CountdownProvider>(context, listen: false)
                        .setCountdownDuration(const Duration(minutes: 10));
                  },
            child: const Text("5 min"),
          ),
          ElevatedButton(
            onPressed: botonActivo == BotonesTiempoEnum.N
                ? null
                : () {
                    botonActivo = BotonesTiempoEnum.N;
                    setState(() {});
                    Provider.of<CountdownProvider>(context, listen: false)
                        .setCountdownDuration(const Duration(minutes: 10));
                  },
            child: const Text("10 min"),
          ),
          ElevatedButton(
            onPressed: botonActivo == BotonesTiempoEnum.B
                ? null
                : () {
                    botonActivo = BotonesTiempoEnum.B;
                    setState(() {});
                    Provider.of<CountdownProvider>(context, listen: false)
                        .setCountdownDuration(const Duration(minutes: 15));
                  },
            child: const Text("15 min"),
          ),
          ElevatedButton(
            onPressed: botonActivo == BotonesTiempoEnum.V
                ? null
                : () {
                    botonActivo = BotonesTiempoEnum.V;
                    setState(() {});
                    Provider.of<CountdownProvider>(context, listen: false)
                        .setCountdownDuration(const Duration(minutes: 20));
                  },
            child: const Text("20 min"),
          ),
        ],
      ),
    );
  }
}
