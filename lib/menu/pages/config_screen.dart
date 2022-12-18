import 'package:flutter/material.dart';
import 'package:mastergoal/audio.dart';
import 'package:mastergoal/clock/providers/coubtdown_provider.dart';
import 'package:mastergoal/values/textStyle_app.dart';
import 'package:provider/provider.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});
  static const path = '/config';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // Lottie.asset(name)
            RichText(
                text: TextSpan(children: [
              TextSpan(text: "El modo de juego es de ", style: textBase),
              TextSpan(
                text: "Nivel 1",
                style: textBase.copyWith(color: Colors.green),
              )
            ])),
            const Text(
              "Selecciona el tiempo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const BotonesTiempo(),
            ElevatedButton(
              onPressed: () {
                Provider.of<AudioProvider>(context).stop();
              },
              child: context.select((AudioProvider audiop) => audiop.isStop)
                  ? const Text("Activar audio")
                  : const Text("Desactivar audio"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).repl
                Navigator.of(context).pop();
              },
              child: const Text("Volver a menu principal"),
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
