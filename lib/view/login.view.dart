import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
            child: Form(
              //autovalidateMode: AutovalidateMode.disabled,
              key: formkey,
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontSize: 20,
                      )
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      EmailValidator(errorText: "Enter valid email id"),
                    ]),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
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
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(6, errorText: "Password should be atleast 6 characters"),
                      MaxLengthValidator(15, errorText: "Password should not be greater than 15 characters")
                    ])
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(
                            horizontal: 130, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 25, 
                            fontWeight: FontWeight.bold)),
                        onPressed: () => {
                          if (formkey.currentState!.validate()) {
                            
                          }
                        },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Text("Não Tem cadastro? "),
                      GestureDetector(
                        child: Text(
                          "Cadastre-se",
                          style: TextStyle(
                            color: Colors.blue
                          )
                        ),
                        onTap: () => (Navigator.pushNamed(context, '')),
                      )
                    ]
                  ),
                ]
              ),
            ),  
        )
    );
  }
}