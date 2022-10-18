import 'package:flutter/material.dart';

class TituloPage extends StatelessWidget {
  final tituloSubrayado;
  final subTitulo;
  const TituloPage({Key? key, this.subTitulo, this.tituloSubrayado})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              tituloSubrayado,
              style: const TextStyle(
                // color: Colors.brown,
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: ContraText(
              alignment: Alignment.center,
              text: subTitulo,
              size: 26,
              // color: Colors.brown,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ContraText extends StatelessWidget {
  final Alignment? alignment;
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const ContraText(
      {this.alignment,
      this.text,
      this.size,
      this.color,
      this.weight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: Text(
        text ?? '',
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          fontSize: size ?? 36,
          fontWeight: weight ?? FontWeight.w800,
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}
