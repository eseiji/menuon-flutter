import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool? _rememberMe = false;
  String email = '';
  String senha = '';
  String nome = '';
  String cpf = '';
  String telefone = '';

  final _phoneTextFieldController = TextEditingController();
  final _cpfTextFieldController = TextEditingController();

  int _phoneMaskType = 0;

  double? spaceBtw = 5;
  double? sizeBox = 50;
  // double? sizeBox = 50.0;

  final kHintTextStyle = const TextStyle(
    color: Colors.white54,
    // fontFamily: 'OpenSans',
  );

  final kLabelStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    // fontFamily: 'OpenSans',
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

  final cellphoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {
        "#": RegExp(r'\d'),
      },
      type: MaskAutoCompletionType.lazy);

  final cpfMaskFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {
        "#": RegExp(r'\d'),
      },
      type: MaskAutoCompletionType.lazy);

  void cadastro(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await auth.createUserWithEmailAndPassword(
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso.'),
          ),
        );

        Navigator.of(context).pushNamed('/login');
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }

  void checkPhoneNumber(String text) {
    if (text.length > 5) {
      if (text.indexOf('9') == 5) {
        _phoneTextFieldController.value =
            cellphoneMaskFormatter.updateMask(mask: '(##) #####-####');
        _phoneMaskType = 9;
        setState(() {});
      } else {
        _phoneTextFieldController.value =
            cellphoneMaskFormatter.updateMask(mask: '(##) ####-####');
        _phoneMaskType = 8;
        setState(() {});
      }
    }
  }

  Widget _buildNameFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: spaceBtw),
        TextFormField(
          keyboardType: TextInputType.name,
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
              Icons.person,
              color: Colors.white,
            ),
            hintText: 'Nome',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
            errorBorder: kErrorBorder,
            errorStyle: kErrorStyle,
          ),
          onSaved: (value) => nome = value!,
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

  Widget _buildCpfFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: spaceBtw),
        TextFormField(
          controller: _cpfTextFieldController,
          inputFormatters: [cpfMaskFormatter],
          keyboardType: TextInputType.number,
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
              Icons.article,
              color: Colors.white,
            ),
            hintText: 'CPF',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
            errorBorder: kErrorBorder,
            errorStyle: kErrorStyle,
          ),
          onSaved: (value) => cpf = value!,
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

  Widget _buildPhoneFT() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: spaceBtw),
        TextFormField(
          controller: _phoneTextFieldController,
          inputFormatters: [cellphoneMaskFormatter],
          onChanged: checkPhoneNumber,
          keyboardType: TextInputType.phone,
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
              Icons.phone,
              color: Colors.white,
            ),
            hintText: 'Telefone',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
            ),
            errorBorder: kErrorBorder,
            errorStyle: kErrorStyle,
          ),
          onSaved: (value) => telefone = value!,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo obrigatório';
            } else {
              if (!GetUtils.isPhoneNumber(value) ||
                  (_phoneMaskType == 9 &&
                      !GetUtils.isLengthEqualTo(value, 15)) ||
                  (_phoneMaskType == 8 &&
                      !GetUtils.isLengthEqualTo(value, 14))) {
                return "Número inválido";
              }
            }
            return null;
          },
        ),
      ],
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
            // fontFamily: 'OpenSans',
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

  Widget _buildCadastroBtn() {
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
              onPressed: () => cadastro(context),
              child: const Text(
                'Cadastrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                'Nova conta',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Informe seus dados para cadastrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        _buildNameFT(),
                        SizedBox(height: 10.0),
                        _buildCpfFT(),
                        SizedBox(height: 10.0),
                        _buildPhoneFT(),
                        SizedBox(height: 10.0),
                        _buildEmailFT(),
                        SizedBox(height: 10.0),
                        _buildPasswordFT(),
                        SizedBox(height: 40.0),
                        _buildCadastroBtn(),
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
