import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';

  double? spaceBtw = 5;
  double? sizeBox = 50.0;

  final kHintTextStyle = const TextStyle(
    color: Colors.white54,
    fontFamily: 'OpenSans',
  );

  final kLabelStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: const Color(0xFF252A34),
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        var result = await auth.signInWithEmailAndPassword(
          email: email,
          password: senha,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login realizado com sucesso.'),
          ),
        );

        Navigator.of(context).pushNamed('/scan');
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            messageAlert('E-mail inválido.');
            break;
          case 'wrong-password':
            messageAlert('Senha incorreta.');
            break;
          case 'user-not-found':
            messageAlert('Usuário não encontrado.');
            break;
          case 'user-disabled':
            messageAlert('Conta desabilitada temporariamente.');
            break;
        }
      }
    }
  }

  void messageAlert(String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget _buildEmailFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: spaceBtw),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: sizeBox,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'E-mail',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              ),
            ),
            onSaved: (value) => email = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: spaceBtw),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: sizeBox,
          child: TextFormField(
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Senha',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontStyle: FontStyle.normal,
              ),
            ),
            onSaved: (value) => senha = value!,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xFF5767FE),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15.0,
                )
              ],
              // color: Color(0xFF7540EE).withOpacity(.2),
            ),
            child: TextButton(
              onPressed: () => login(context),
              child: const Text(
                'Entrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: (() => {}),
        child: const Text('Esqueceu a senha?',
            style: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontSize: 12.0,
            )),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Get.toNamed('/register'),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Ainda não possui uma conta?  ',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
            TextSpan(
              text: 'Cadastre-se',
              style: TextStyle(
                color: const Color(0xFF5767FE),
                fontSize: 15.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF5767FE),
        title: Container(
          child: Row(
            children: const [
              Icon(FontAwesomeIcons.wineGlassAlt),
              SizedBox(width: 5.0),
              Text(
                'MENU ON',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Options',
            onPressed: () {},
          ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                color: Color(0xff181920),
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 10.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
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
                              const SizedBox(height: 5),
                              const Text(
                                'Informe seus dados de acesso',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        _buildEmailFT(),
                        SizedBox(height: 10.0),
                        _buildPasswordFT(),
                        _buildForgotPasswordBtn(),
                        SizedBox(height: 40.0),
                        _buildLoginBtn(),
                        SizedBox(height: 40.0),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
