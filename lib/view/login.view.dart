import 'package:firebase_auth/firebase_auth.dart';
import '../view/layout.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        var result = await auth.signInWithEmailAndPassword(
            email: email, password: senha);

        Navigator.of(context).pushNamed('/scan');

      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            print(context);
            print(e.code);
            break;
          case 'wrong-password':
            print(context);
            print(e.code);
            break;
          case 'user-not-found':
            print(context);
            print(e.code);
            _showMyDialog(context);
            break;
          case 'user-disabled':
            print(context);
            print(e.code);
            break;
        }
      }
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
      backgroundColor: Colors.black,
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Align(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(FontAwesomeIcons.wineGlassAlt, color: Color(0xFF7540EE)),
                      SizedBox(width: 10),
                      Text('MENU ON',
                          style: TextStyle(
                            color: Color(0xFF7540EE),
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Bem-vindo(a)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        )),
                      const SizedBox(height: 20),
                      const Text('Informe seus dados de acesso para entrar no aplicativo',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          )),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'E-mail',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onSaved: (value) => email = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo e-mail obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onSaved: (value) => senha = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo senha obrigatório';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text('Esqueceu a senha?',
                              style: TextStyle(
                                color: Colors.white70,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF7540EE),
                          // color: Color(0xFF7540EE).withOpacity(.2),
                        ),
                        child: TextButton(
                              onPressed: () => login(context),
                              child: const Text('Entrar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                      )
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Ainda não tem uma conta? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        )),
                        TextButton(
                            onPressed: (() => Get.toNamed('/cadastrar')),
                            child: const Text('Cadastre-se',
                              style: TextStyle(
                                color: Color(0xFF7540EE),
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
