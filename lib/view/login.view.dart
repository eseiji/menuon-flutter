import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var modalFormKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';

  String emailResetPwd = '';

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

  final kDefaultBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF5767FE),
    ),
  );

  final kErrorBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      width: 1,
      color: Color(0xFF5767FE),
    ),
  );

  final kErrorStyle = const TextStyle(
    fontSize: 13,
    color: Color(0xFF5767FE),
    fontStyle: FontStyle.normal,
  );

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) @####-####',
      filter: {"#": RegExp(r'[0-9]'), "@": RegExp(r'[0-9]?')},
      type: MaskAutoCompletionType.lazy);

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        var result = await auth.signInWithEmailAndPassword(
          email: email,
          password: senha,
        );

        messageAlert('Login realizado com sucesso.');

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

  void resetPassword(BuildContext context) async {
    if (modalFormKey.currentState!.validate()) {
      modalFormKey.currentState!.save();

      try {
        var result = await auth.sendPasswordResetEmail(
          email: email,
        );

        Navigator.pop(context);

        messageAlert('E-mail enviado.');
      } on FirebaseAuthException catch (e) {
        print(e);
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
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF252A34),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: kDefaultBorder,
            focusedErrorBorder: kDefaultBorder,
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: 'E-mail',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
            errorBorder: kErrorBorder,
            errorStyle: kErrorStyle,
          ),
          onSaved: (value) => email = value!,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo obrigatório';
            }
            if (!GetUtils.isEmail(value)) {
              return "E-mail inválido";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: spaceBtw),
        TextFormField(
          obscureText: true,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF252A34),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: kDefaultBorder,
            focusedErrorBorder: kDefaultBorder,
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Senha',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
            errorBorder: kErrorBorder,
            errorStyle: kErrorStyle,
          ),
          onSaved: (value) => senha = value!,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo obrigatório';
            }
            return null;
          },
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
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            // barrierColor: Colors.purple,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 50.0,
                ),
                // height: 200,
                // height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: Color(0xff181920),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Form(
                  key: modalFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // const SizedBox(height: 30.0),
                      Container(
                        // padding: EdgeInsets.only(
                        // bottom: MediaQuery.of(context).viewInsets.bottom),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // Text(d
                            //   'Bem-vindo(a)',
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 21,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // SizedBox(height: 5),
                            Text(
                              'Recebe em seu e-mail, um link para recuperar a senha',
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            _buildEmailFT(),
                            const SizedBox(height: 40.0),
                            _buildSendEmailResetPwdBtn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: <Widget>[
                //       const Text('Modal BottomSheet'),
                //       ElevatedButton(
                //         child: const Text('Close BottomSheet'),
                //         onPressed: () => Navigator.pop(context),
                //       )
                //     ],
                //   ),
                // ),
              );
            },
          );
        },
        child: const Text('Esqueceu a senha?',
            style: TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontSize: 12.0,
            )),
      ),
    );
  }

  Widget _buildSendEmailResetPwdBtn() {
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
            ),
            child: TextButton(
              onPressed: () => resetPassword(context),
              child: const Text(
                'Recuperar senha',
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
                color: const Color(0xff181920),
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
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
                            children: const [
                              Text(
                                'Bem-vindo(a)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Informe seus dados de acesso',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        _buildEmailFT(),
                        const SizedBox(height: 10.0),
                        _buildPasswordFT(),
                        _buildForgotPasswordBtn(),
                        const SizedBox(height: 40.0),
                        _buildLoginBtn(),
                        const SizedBox(height: 40.0),
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
