import 'package:flutter/material.dart';

class Baslik extends StatelessWidget {
  final String text;
  Baslik({Key key, this.text});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 204, 82, 82),
              fontWeight: FontWeight.bold),
        ),
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ),
        duration: Duration(
          milliseconds: 5000,
        ),
        curve: Curves.bounceOut,
        builder: (BuildContext context, double value, Widget child) {
          return Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(top: value * 25),
              child: child,
            ),
          );
        });
  }
}
