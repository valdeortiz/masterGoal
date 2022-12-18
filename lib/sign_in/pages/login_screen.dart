import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/game_coordinator_provider.dart';
import 'package:provider/provider.dart';
import '../../menu/pages/menu_screen.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  static const loginPath = '/login';

  @override
  Widget build(BuildContext context) {
    final TextEditingController userName = TextEditingController(text: "");
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/madera.jpg"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(children: <Widget>[
              //Container del Gif
              Container(
                  child: Lottie.asset('assets/lottie/sign-in.json',
                      width: 200, height: 200)),

              //Titulo 'Bienvenido a MasterGoal'
              const Text(
                "Bienvenido a\nMasterGoal",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NovaRound'),
              ),
              const SizedBox(
                height: 40,
              ),

              //TextFiel de Nombre
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    maxLength: 10,
                    controller: userName,
                    decoration: const InputDecoration(
                        hintText: "Ingrese su Nombre",
                        icon: Icon(Icons.account_circle_outlined)),
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //Button Ingresar
              ElevatedButton.icon(
                  icon: const Icon(
                    Icons.login_outlined,
                  ),
                  label: const Text("Ingresar", style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 14),
                  ),
                  onPressed: () {
                    Provider.of<GameCoordProvider>(context, listen: false)
                        .namePlayer1 = userName.text;
                    Navigator.pushNamed(context, MenuPrincipal.menuPath);
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
