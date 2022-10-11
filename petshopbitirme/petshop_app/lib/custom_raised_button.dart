import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.onPressed,
    this.borderRadius: 12.0,
    this.height: 50.0,
    this.width,
  }) : assert(borderRadius != null);

  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    print('BUILD CustomRaisedButton');
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
          ),
        ),
        // style: ElevatedButton.styleFrom(
        //   onPrimary: color,
        //   textStyle: TextStyle(color: Colors.white),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(borderRadius),
        //     ),
        //   ),
        // ),
        onPressed: onPressed,
      ),
    );
  }
}
