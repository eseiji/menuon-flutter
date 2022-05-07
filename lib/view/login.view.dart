import '../view/layout.view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(FontAwesomeIcons.wineGlassAlt, color: Color(0xFF7540EE)),
                SizedBox(width: 10),
                Text('Menu ON',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFF7540EE),
                    )),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Bem-vindo ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                Text('Informe seus dados de acesso para entrar no aplicativo',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    )),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Email',
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
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
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
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () => Get.toNamed(''),
                  child: Text('Entrar',
                      style: TextStyle(
                        color: Color(0xFF7540EE),
                        fontWeight: FontWeight.bold,
                      )),
                  color: Color(0xFF7540EE).withOpacity(.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Text('Esqueceu sua senha?',
                    style: TextStyle(
                      color: Color(0xFF7540EE),
                      fontStyle: FontStyle.italic,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Text('Ainda não tem uma conta? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    )),
                FlatButton(
                  onPressed: (() => Get.toNamed('/cadastrar')),
                  child: Text(
                    'Criar uma',
                    style: TextStyle(
                      color: Color(0xFFFF7052),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
