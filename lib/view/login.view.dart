import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/alertDialog.dart';

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
      Navigator.of(context).pushNamed('/cadastro');
    } on FirebaseAuthException catch (e) {
      authException(e);
      showAlertDialog(context, 'Atenção', errorMsg);
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
                    Text(
                      "Sign in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Faça login para ter acesso a todas as funcionalidade"),
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                            )),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Campo obrigatório"),
                          EmailValidator(errorText: "Email inválido"),
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
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
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF3b8132),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      onPressed: () => {
                        if (formkey.currentState!.validate())
                          {
                            login(context),
                          }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Não tem cadastro? "),
                      GestureDetector(
                        child: Text("Cadastre-se",
                            style: TextStyle(color: Colors.blue)),
                        onTap: () =>
                            (Navigator.pushNamed(context, '/cadastro')),
                      )
                    ]),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
