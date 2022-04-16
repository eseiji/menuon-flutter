import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/mensagem.model.dart';
import 'package:whatsapp_clone/view/mensagemitem.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MensagemView extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('Mensagens')
            .where('usuarios', arrayContains: auth.currentUser!.uid)
            .orderBy('dataUltimaMensagem', descending: true)
            .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          if (snapshot.hasError) return Text("Erro ao carregar os dados");

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) => MensagemItem(
                MensagemModel.fromMap(snapshot.data!.docs[index].data())),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: () {
          auth.signOut();
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
    );
  }
}
