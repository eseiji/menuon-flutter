import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String telefone = '';
  String senha = '';

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // var result = await auth.createUserWithEmailAndPassword(
      //     email: email, password: senha);



      // TROCAR POR TELEFONE E SENHA
      // var result = await auth.signInWithEmailAndPassword(email: email, password: senha);





      // print(result.user!.uid);

      Navigator.of(context).pushNamed('/mensagens');
    }
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // TextFormField(
              //   onSaved: (value) => telefone = value!,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Campo e-mail obrigatório';
              //     }
              //     return null;
              //   },
              // ),
              Container(
                width: 500,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: 
                TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Telefone',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical:5, horizontal: 13),
                  ),
                  onSaved: (value) => telefone = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                    return 'Campo telefone obrigatório';
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
                      Icons.key,
                      color: Colors.black54,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical:5, horizontal: 13),
                  ),
                  obscureText: true,
                  onSaved: (value) => senha = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo senha obrigatório';
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
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => save(context),
                  child: Text("Entrar"),
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
