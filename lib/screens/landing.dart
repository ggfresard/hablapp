import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hablapp/screens/login.dart';
import 'package:hablapp/screens/registration.dart';
import 'package:hablapp/widgets/utils.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = 'landing-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    width: 100,
                    height: 120,
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                ),
              ),
              Text(
                "Habl",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 40,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                "app",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 40,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(
            height: 80,
          ),
          CustomButton(
            text: 'Entrar',
            callback: () {
              Navigator.of(context).pushNamed(LoginPage.routeName);
            },
          ),
          CustomButton(
            text: 'Registrarse',
            callback: () {
              Navigator.of(context).pushNamed(RegistrationPage.routeName);
            },
          ),
        ],
      ),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
