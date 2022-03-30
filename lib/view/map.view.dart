import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MapView extends StatefulWidget {
  // const MapView({
  //   Key? key,
  //   this.color = const Color(0xFFFFE306),
  //   this.child,
  // }) : super(key: key);

  // final Color color;
  // final Widget? child;

  @override
  // State<MapView> createState() => _MapViewState();
  State<StatefulWidget> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  double _size = 1.0;

  String _name = '';
  String _email = '';
  Map<String, dynamic> _userInfo = {};
  int _totalUsers = 0;

  void grow() {
    setState(() {
      _size += 0.1;
    });
  }

  Future<Map> users() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/users/1');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      // convert.jsonDecode(response.body) as Map<String, dynamic>;

      // _name = jsonResponse['name'];
      // _email = jsonResponse['email'];

      // print('$_name!');
      // print('$_email!');

      _userInfo = {'name': jsonResponse['name'], 'email': jsonResponse['email']};
      // userInfo = [name, email];
      // print(userInfo);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: widget.color,
        // transform: Matrix4.diagonal3Values(_size, _size, 1.0),
        // child: widget.child,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await users();
              setState(() {
                _name = _userInfo['name'];
                _email = _userInfo['email'];
                _totalUsers = _userInfo.length;
              });
            },
            child: Text("Get users"),
          ),
          Text('Nome: $_name'),
          Text('Email: $_email'),
          Text('Total: $_totalUsers'),
        ],
    ));
  }
}

// class MapView extends StatelessWidget {
//   var formKey = GlobalKey<FormState>();
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   String name = '';
//   String email = '';
//   // Map<String, dynamic> usersInfo = {};
//   List<String> usersInfo = [];

//   Future users() async {
//     var url = Uri.https('jsonplaceholder.typicode.com', '/users/1');

//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       var jsonResponse =
//           convert.jsonDecode(response.body) as Map<String, dynamic>;
//       name = jsonResponse['name'];
//       email = jsonResponse['email'];

//       print('$name!');
//       print('$email!');

//       // usersInfo = {'name': name, 'email': email};
//       usersInfo = [name, email];
//       print(usersInfo);

//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//     return usersInfo;
//   }

//   @override
//   Widget build(BuildContext context) {
//     users();
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: users,
//               child: Text("Carregar users"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
