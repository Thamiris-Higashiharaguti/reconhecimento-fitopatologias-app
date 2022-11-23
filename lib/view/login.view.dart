import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopatologia_app/view/components/alerts.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../color.dart';
import 'components/alerts.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMsg = '';

  void login(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      var result = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      authException(e);
      showInfoAlert(context, 'Atenção', errorMsg);
    }
  }

  void authException(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      errorMsg = 'Usuário não cadastrado';
    } else if (e.code == 'wrong-password' || e.code == 'invalid-email') {
      errorMsg = 'Credenciais incorretas';
    } else {
      errorMsg = 'Entre em contato com o administrador do sistema';
    }
  }

  void cadastrar(BuildContext context) {
    Navigator.pushNamed(context, '/cadastro');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(40, size.height * 0.2, 40, 0),
                child: Form(
                  //autovalidateMode: AutovalidateMode.disabled,
                  key: formkey,
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: size.height * 0.04,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                      child: Text(
                          "Faça login para ter acesso a todas as funcionalidade",
                          style: TextStyle(fontSize: size.height * 0.02)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: size.height * 0.03,
                              )),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Campo obrigatório"),
                            EmailValidator(errorText: "Email inválido"),
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: size.height * 0.03,
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Campo obrigatório"),
                            MinLengthValidator(6,
                                errorText:
                                    "A senha deve conter no mínimo 6 caracteres"),
                            PatternValidator(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$',
                                errorText:
                                    'A senha deve conter números, letras maiúsculas e minúsculas')
                          ])),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      GestureDetector(
                        child: Text("Esqueci minha senha",
                            style: TextStyle(
                                color: Tema.primaryColor,
                                fontSize: size.height * 0.015)),
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotPassword');
                        },
                      )
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Entrar"),
                        style: ElevatedButton.styleFrom(
                            primary: Tema.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          if (formkey.currentState!.validate())
                            {
                              login(context),
                            }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Criar conta"),
                        style: ElevatedButton.styleFrom(
                            primary: Tema.primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold)),
                        onPressed: () => cadastrar(context),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
