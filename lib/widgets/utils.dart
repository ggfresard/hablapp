import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Material(
          color: Theme.of(context).accentColor,
          elevation: 6,
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            onPressed: callback,
            minWidth: 200,
            height: 45,
            child: Text(
              text,
              style:
                  TextStyle(fontFamily: "Comfortaa", fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
