import 'package:flutter/material.dart';

import 'custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Color color,
    Color textColor,
    @required String text,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: textColor,
            ),
          ),
          color: color,
          onPressed: onPressed,
        );
}
