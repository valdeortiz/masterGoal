import 'package:flutter/material.dart';

class InputSignIn extends StatelessWidget {
  final TextEditingController? inputController;
  final Function(String)? onChange;
  // final FocusNode? focusNode;

  const InputSignIn({Key? key, this.inputController, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: onChange,
        textAlign: TextAlign.left,
        // style: GoogleFonts.aBeeZee(fontSize: 17.0),
        keyboardType: TextInputType.text,
        controller: inputController,
        maxLines: 1,
        maxLength: 20,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          prefixIcon: Icon(Icons.contact_mail_outlined),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFeeeeee),
                // color: Colors.grey[400],
                // color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFeeeeee),
                // color: verdeMas,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          hintText: 'Ingrese su nombre',
          // hintStyle: GoogleFonts.aBeeZee(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
