import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/alerts.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  String errorMsg = '';

  void enviaEmail(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: emailController.text);
  }

  void buscaEmail(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var usuario = await firestore
        .collection('usuarios')
        .where('email', isEqualTo: emailController.text)
        .get();

    if (usuario.docs.isNotEmpty) {
      enviaEmail(context);
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
                  key: formkey,
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Redefinir senha",
                          style: TextStyle(
                              fontSize: size.height * 0.04,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                      child: Text(
                          "Insira o email da conta para redefinir a senha",
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
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Enviar"),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF3b8132),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          buscaEmail(context)
                        },
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
