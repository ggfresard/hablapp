import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hablapp/widgets/utils.dart';

import 'chat.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ChatPage(user: user,)),
      (route) => false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hablapp"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                tag: 'logo',
                child: Container(
                  width: 100,
                  height: 20,
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
              hintText: 'Ingrese Email',
              border: const OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          TextField(
            onChanged: (value) => password = value,
            decoration: InputDecoration(
              hintText: 'Ingrese contraseña',
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          CustomButton(
              callback: () async {
                await loginUser();
              },
              text: 'Entrar')
        ],
      ),
    );
  }
}
