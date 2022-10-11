import 'package:flutter/material.dart';
import 'package:petshop_app/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    Color color,
    Color textColor,
    @required String text,
    @required String assetName,
    VoidCallback onPressed,
  })  : assert(text != null),
        assert(assetName != null),
        super(
          child: Row(
            children: <Widget>[
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                  fontSize: 13.0,
                  color: textColor,
                ),
              ),
              Opacity(
                child: Image.asset(assetName),
                opacity: 0.0,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          color: color,
          onPressed: onPressed,
        );
}
