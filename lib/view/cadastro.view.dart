import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/alertDialog.dart';

class CadastroView extends StatefulWidget {
  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  
  TextEditingController apelidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void cadastrar(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    var usuario = await firestore.collection('usuarios').where('email', isEqualTo: emailController.text).get();
    if (usuario.docs.isNotEmpty) {
      showAlertDialog(context, 'Atenção', 'Email já cadastrado');
      Navigator.of(context).pop();
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
    return Scaffold(
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  Text(
                    "Cadastro", 
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Faça cadastro para ter acesso a todas as funcionalidade"
                  ),
                  SizedBox(height: 100,),
                  TextFormField(
                    controller: apelidoController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Apelido",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 20,
                      )
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Campo obrigatório"),
                    ])
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 20,
                      )
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Campo obrigatório"),
                      EmailValidator(errorText: "Email inválido"),
                    ])
                  ),
                  SizedBox(height: 10,),
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
                      MinLengthValidator(6, errorText: "A senha deve conter no mínimo 6 caracteres"),
                      PatternValidator(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$', errorText: 'A senha deve conter números, letras maiúsculas e minúsculas')
                    ])
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirme a senha",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 20,
                      ),
                    ),
                    validator: (value) => MatchValidator(errorText: 'A senha não confere').validateMatch(confirmPasswordController.text, passwordController.text),  
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    child: Text("Cadastrar"),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF3b8132),
                        padding: EdgeInsets.symmetric(
                            horizontal: 130, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold
                            )
                    ),
                    onPressed: () => {
                      if (formkey.currentState!.validate()) {
                        
                      }
                    },
                  ),
                ]
              ),
            ),  
        )
    );
  }
}