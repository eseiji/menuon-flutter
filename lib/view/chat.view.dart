import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController txtCtrl = new TextEditingController();

  bool showMicIcon = true;

  void sendMessage() async {
    var message = txtCtrl.text;
    await firestore.collection('conversas').add({
      "mensagem": message,
      "data": DateTime.now(),
      "uid": auth.currentUser!.uid,
      "email": auth.currentUser!.email
    });
    txtCtrl.clear();
  }

  // Map<String, dynamic> styles(msg) {
  //   if (snapshot.data!.docs[index].data()['uid'] == auth.currentUser!.uid) {}
  //   return {"sim": "message"};
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: firestore.collection('conversas').snapshots(),
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          return Container(
                            child: Row(
                              children: [
                                Container(
                                    child: /*Text(snapshot.data!.docs[index]
                                      .data()['mensagem']),
                                  decoration: BoxDecoration(
                                    color: snapshot.data!.docs[index]
                                                .data()['uid'] ==
                                            auth.currentUser!.uid
                                        ? Colors.lightGreen
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 13),
                                  margin: EdgeInsets.fromLTRB(16, 8, 9, 0),*/
                                        const Align(
                                  child: Text('Teste'),
                                )),
                              ],
                            ),
                          );
                        });
                  }),
            ),
            Container(
              height: 90,
              child: Row(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 9, 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: TextField(
                      controller: txtCtrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.face),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() => showMicIcon = true);
                        } else {
                          setState(() => showMicIcon = false);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(9, 0, 17, 0),
                  child: showMicIcon
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.mic),
                        )
                      : IconButton(
                          onPressed: sendMessage,
                          icon: Icon(Icons.send),
                        ),
                ),
              ]),
            )
          ],
        ));
  }
}
