import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  // LIMITE DE REQUISIÇÕES ATINGIDO
  // late Future<List<dynamic>> _userRepositories;
  late Future<String> company;
  late Future<String> color;
  // late List<dynamic> _userRepositories;

  Future<String> getCompany() async {
    late String company;
    final prefs = await SharedPreferences.getInstance();
    print('JA PASSOU');
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final companyFromSharedPref = prefs.getString('company');

    if (arguments['company'] != null) {
      company = arguments['company'];
    } else {
      company = companyFromSharedPref!;
    }
    return company;
  }

  void signout(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('company');
    await auth.signOut();

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  // Future<String> buscarCorPersonalizada() async {
  //   var collection = FirebaseFirestore.instance.collection('cardapio');
  //   var docSnapshot = await collection.doc(company).get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     color = data?['corPersonalizada'];
  //     return color;
  //   } else {
  //     return '0xFF5767FE';
  //   }
  // }

  @override
  void initState() {
    // LIMITE DE REQUISIÇÕES ATINGIDO
    // _userRepositories = apiGithub.searchRepositories();
    // _userRepositories = apiGithub.repositories;
    company = getCompany();
    // color = buscarCorPersonalizada(company);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: FutureBuilder(
        future: company,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(child: Text('$error'));
          } else if (snapshot.hasData) {
            final String repo = snapshot.data as String;
            return AppBar(
              backgroundColor: const Color(0xff181920),
              elevation: 2,
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '$company',
                      style: TextStyle(
                        // color: Color.fromARGB(255, 255, 255, 255),
                        color: Color(0xFF1111FF),
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => signout(context),
                  icon: Icon(Icons.logout_rounded),
                ),
                IconButton(
                  onPressed: () => Get.toNamed(
                    '/cart',
                    arguments: {'company': company},
                  ),
                  icon: Icon(Icons.shopping_basket_rounded),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
