import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../view/layout.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CadastroPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';
  String nome = '';
  String cpf = '';
  String telefone = '';

  void cadastro(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await firestore.collection('clientes').add({
        "nome": nome,
        "cpf": cpf,
        "telefone": telefone,
        "email": email,
        "data": DateTime.now(),
      });

      Navigator.of(context).pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(FontAwesomeIcons.wineGlassAlt,
                        color: Color(0xFF7540EE)),
                    SizedBox(width: 10),
                    Text(
                      'MENU ON',
                      style: TextStyle(
                        color: Color(0xFF7540EE),
                        fontSize: 22,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bem-vindo(a)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Informe seus dados para cadastrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Nome',
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
                      onSaved: (value) => nome = value!,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo nome obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'CPF',
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
                      onSaved: (value) => cpf = value!,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo CPF obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Telefone',
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
                      onSaved: (value) => telefone = value!,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo telefone obrigatório';
                        }
                        return null;
                      },
                    ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
