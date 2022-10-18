import 'package:flutter/material.dart';

class BotonSiguiente extends StatelessWidget {
  const BotonSiguiente({
    Key? key,
    this.onTap,
    this.titulo,
    this.color,
  }) : super(key: key);

  final Function()? onTap;
  final String? titulo;
  // final icono;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: color ?? Colors.lime[500],
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  titulo ?? '',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  // style: GoogleFonts.aBeeZee(
                  //   color: Colors.white,
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
              ),
            ),
            const Icon(
              Icons.input,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
