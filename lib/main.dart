import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hablapp/screens/chat.dart';
import 'package:hablapp/screens/landing.dart';
import 'package:hablapp/screens/login.dart';
import 'package:hablapp/screens/registration.dart';

void main() => runApp(MyApp());

Map<int, Color> swatch = {
  50: Color.fromRGBO(35, 31, 32, .1),
  100: Color.fromRGBO(35, 31, 32, .2),
  200: Color.fromRGBO(35, 31, 32, .3),
  300: Color.fromRGBO(35, 31, 32, .4),
  400: Color.fromRGBO(35, 31, 32, .5),
  500: Color.fromRGBO(35, 31, 32, .6),
  600: Color.fromRGBO(35, 31, 32, .7),
  700: Color.fromRGBO(35, 31, 32, .8),
  800: Color.fromRGBO(35, 31, 32, .9),
  900: Color.fromRGBO(35, 31, 32, 1),
};
Map<int, Color> color = {
  50: Color.fromRGBO(118, 185, 0, .1),
  100: Color.fromRGBO(118, 185, 0, .2),
  200: Color.fromRGBO(118, 185, 0, .3),
  300: Color.fromRGBO(118, 185, 0, .4),
  400: Color.fromRGBO(118, 185, 0, .5),
  500: Color.fromRGBO(118, 185, 0, .6),
  600: Color.fromRGBO(118, 185, 0, .7),
  700: Color.fromRGBO(118, 185, 0, .8),
  800: Color.fromRGBO(118, 185, 0, .9),
  900: Color.fromRGBO(118, 185, 0, 1),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hablapp',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: MaterialColor(0xFF231F20, swatch),
          accentColor: MaterialAccentColor(0xFF76B900, color),
          primaryIconTheme: IconThemeData(
            color: MaterialAccentColor(0xFF76B900, color)
          ),
          primaryTextTheme: TextTheme(
              title: TextStyle(
                  fontFamily: "Comfortaa",
                  color: MaterialAccentColor(0xFF76B900, color))),
          accentTextTheme: TextTheme(
              title: TextStyle(
                  fontFamily: "Comfortaa",
                  color: MaterialAccentColor(0xFF76B900, color))),
          textTheme: TextTheme(
              title: TextStyle(
                  fontFamily: "Comfortaa",
                  color: MaterialAccentColor(0xFF76B900, color)))),
      home: MyHomePage(),
      initialRoute: LandingPage.routeName,
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        ChatPage.routeName: (ctx) => ChatPage(),
        RegistrationPage.routeName: (ctx) => RegistrationPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LandingPage();
  }
}
