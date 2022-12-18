import 'package:flutter/material.dart';
import 'package:mastergoal/audio.dart';
import 'package:mastergoal/clock/providers/coubtdown_provider.dart';
import 'package:provider/provider.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});
  static const path = '/config';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            "Selecciona el tiempo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<CountdownProvider>(context)
                      .setCountdownDuration(const Duration(minutes: 10));
                },
                child: const Text("10 min"),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CountdownProvider>(context)
                      .setCountdownDuration(const Duration(minutes: 15));
                },
                child: const Text("15 min"),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<CountdownProvider>(context)
                      .setCountdownDuration(const Duration(minutes: 20));
                },
                child: const Text("20 min"),
              ),
            ],
          ),
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
    );
  }
}
