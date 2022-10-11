import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petshop_app/Screens/home.dart';
import 'package:petshop_app/email_sign_in/email_signup_page.dart';
import 'package:petshop_app/notification_dialog.dart';
import 'package:get/route_manager.dart';

class EmailVerifyScreen extends StatefulWidget {
  EmailVerifyScreen(this._isVerified);
  final bool _isVerified;
  @override
  _EmailVerifyScreenState createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;

  Timer timer;

  @override
  void initState() {
    print("init state verify screen built");
    user = auth.currentUser;

    if (widget._isVerified) {
      checkEmailVerified();
    } else {
      if (auth.currentUser.email != null) {
        user = auth.currentUser;
        user.sendEmailVerification();
      }
    }

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._isVerified
          ? Center(child: CircularProgressIndicator())
          : _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(40.0, 30, 40, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: new Icon(Icons.close),
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => EmailRegisterPage(),
                    ),
                    (route) => false);
              },
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              child: Center(
            child: Text('verification sent'),
          )),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: InkWell(
                onTap: () {
                  user = auth.currentUser;
                  user.sendEmailVerification();

                  Get.dialog(NotificationDialog(
                      title: '', content: 'verification sent'));
                },
                child: Text(
                  'resend verification',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    print(
        "EmailVerifyScreen - emailVerified = " + user.emailVerified.toString());
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
          (route) => false);
    }
  }
}
