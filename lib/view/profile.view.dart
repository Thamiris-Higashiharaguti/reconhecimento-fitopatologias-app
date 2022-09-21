import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitopatologia_app/view/components/background.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/alertDialog.dart';

class ProfileEditView extends StatefulWidget {
  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController apelidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var userUid = '';

  Future carregaUsuario() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser!;
    userUid = user.uid;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var usuario = await firestore.collection('usuarios').doc(userUid).get();

    apelidoController.text = usuario['apelido'];
    emailController.text = usuario['email'];
    passwordController.text = usuario['senha'];

    return userUid;
  }

  void cadastrar(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var usuario = await firestore
        .collection('usuarios')
        .where('email', isEqualTo: emailController.text)
        .get();
    if (usuario.docs.isNotEmpty) {
      showAlertDialog(context, 'Atenção', 'Email já cadastrado');
      await Future.delayed(const Duration(seconds: 4), (){});
      Navigator.pushNamed(context, '/login');
    } else {
      var userAuth = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      firestore.collection("usuarios").doc(userAuth.user!.uid).set({
        'uid': userAuth.user!.uid,
        'apelido': apelidoController.text,
        'email': emailController.text,
        'senha': passwordController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background(
          child: ListView(
            shrinkWrap: false,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(40, size.height * 0.2, 40, 0),
                child: Form(
                  key: formkey,
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("Cadastro", style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                          controller: apelidoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Apelido",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: size.height * 0.03,
                              )),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Campo obrigatório"),
                          ])),
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
                                errorText: "A senha deve conter no mínimo 6 caracteres"),
                            PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$',
                                errorText: 'A senha deve conter números, letras maiúsculas e minúsculas')
                          ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirme a senha",
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: size.height * 0.03,
                          ),
                        ),
                        validator: (value) =>
                            MatchValidator(errorText: 'A senha não confere')
                                .validateMatch(confirmPasswordController.text,
                                    passwordController.text),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Salvar"),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF3b8132),
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: size.height * 0.03, fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          if (formkey.currentState!.validate()) {
                            cadastrar(context),
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        child: Text("Sair"),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF3b8132),
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 20),
                            textStyle: TextStyle(
                                fontSize: size.height * 0.03, fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          if (formkey.currentState!.validate()) {
                            cadastrar(context),
                          }
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        )
      );
  }
  void initState() {
    super.initState();
    final user = carregaUsuario();
  }
}
