import 'dart:developer';
import 'package:flutter/foundation.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  // final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  String confirmPassword = '';

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // try {
      //   var result = await auth.createUserWithEmailAndPassword(email: email, password: password);

      //   Navigator.of(context).pushNamed('/mensagens');

      // } on FirebaseAuthException catch (e) {
      //   switch (e.code) {
      //     case 'invalid-email':
      //       print(context);
      //       print(e.code);
      //       break;
      //     case 'wrong-password':
      //       print(context);
      //       print(e.code);
      //       break;
      //     case 'user-not-found':
      //       print(context);
      //       print(e.code);
      //       _showMyDialog(context);
      //       break;
      //     case 'user-disabled':
      //       print(context);
      //       print(e.code);
      //       break;
      //   }
      // }
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Usuário não encontrado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Verifique suas credenciais e tente novamente.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff303038),
        height: 500,
        margin: EdgeInsets.fromLTRB(50, 50, 50, 50),
        child: Form(
          key: formKey,
          child: Align(
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                  ),
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo e-mail obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                  ),
                  obscureText: true,
                  onSaved: (value) => password = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo senha obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Confirmar senha',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(
                      Icons.check,
                      color: Colors.black54,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                  ),
                  obscureText: true,
                  onSaved: (value) => confirmPassword = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirme sua senha';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.fromLTRB(50, 100, 50, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff28282d),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => save(context),
                  child: Text("Cadastrar"),
                ),
              ),
            ]),
          ),
        ),
      ),
      backgroundColor: Color(0xff28282d),
    );
  }
}
