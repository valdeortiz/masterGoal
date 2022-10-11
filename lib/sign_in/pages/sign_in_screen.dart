import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mastergoal/menu/pages/menu_screen.dart';
import 'package:mastergoal/sign_in/widgets/input.dart';
import 'package:mastergoal/widgets/boton_siguiente.dart';
import 'package:mastergoal/widgets/titulo_page.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  static const singInPath = '/signin';
  final TextEditingController? nombreController = TextEditingController();
  final Function(String)? onChange = ((p0) => '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset('assets/lottie/sign-in.json'),
              const TituloPage(
                tituloSubrayado: 'Inic',
                subTitulo: 'io sesion',
              ),
              const SizedBox(
                height: 20,
              ),
              InputSignIn(
                inputController: nombreController,
              ),
              const SizedBox(
                height: 20,
              ),
              BotonSiguiente(
                titulo: 'Iniciar',
                onTap: () =>
                    Navigator.of(context).pushNamed(MenuPrincipal.menuPath),
              )
            ],
          ),
        ),
      ),
    );
  }
}
