import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // var result = await auth.createUserWithEmailAndPassword(
      //   email: email, password: senha);
      var result =
          await auth.signInWithEmailAndPassword(email: email, password: senha);

      Navigator.of(context).pushNamed('/message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 4, 140, 8).withOpacity(0.5),
                  spreadRadius: 30,
                  blurRadius: 50,
                  offset: Offset(2, 7), // changes position of shadow
                ),
              ],
            ),
            width: 400,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Container(
                    //  child:  Icon(Icons.logout)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*
                        Container(
                          child: Image.asset('assets/images/texting.jpg',width:300,height:100),
                        ),*/
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.login, size: 40, color: Colors.green),
                      ],
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "E-mail Address",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165)),
                          labelText: "E-mail",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.green)),
                          prefixIcon: Icon(Icons.email)),
                      onSaved: (value) => email = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo E-mail obrigatório";
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165)),
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.green)),
                          prefixIcon: Icon(Icons.password)),
                      obscureText: true,
                      onSaved: (value) => senha = value!,
                      validator: (value) {
                        if (value!.isEmpty) return "Campo senha obrigatório";
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => save(context),
                      child: Text("Enter"),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(
                              horizontal: 130, vertical: 20),
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Não Tem cadastro? "),
                      GestureDetector(
                        child: Text("Cadastrar-se",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue)),
                        onTap: () => Navigator.pushNamed(context, '/register'),
                      )
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
