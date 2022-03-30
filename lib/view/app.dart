import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'mensagem.view.dart';
import 'login.view.dart';
import 'map.view.dart';

class App extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // print(auth.currentUser!.uid);
    return MaterialApp(
      home: auth.currentUser == null ? LoginView() : MensagemView(),
      // home: MapView(),
      // home: MensagemView(),
      routes: {
        '/mensagens': (context) => MensagemView(),
        '/login': (context) => LoginView(),
      },
    );
  }
}

// auth.currentUser == null ? LoginView() : 