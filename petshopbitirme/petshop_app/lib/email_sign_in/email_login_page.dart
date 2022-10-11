import 'package:firebase_auth/firebase_auth.dart';
import 'package:petshop_app/email_sign_in/email_verify.dart';
import 'package:petshop_app/email_sign_in/email_signup_page.dart';
import 'package:petshop_app/notification_dialog.dart';
import 'package:petshop_app/sign_in_button.dart';

import 'package:get/get.dart';

// import 'package:food_sharing/app/sign_in/models/sign_in_manager.dart';

import 'package:flutter/material.dart';

class EmailLoginPage extends StatefulWidget {
  EmailLoginPage();
  @override
  _EmailLoginPageState createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage>
    with SingleTickerProviderStateMixin {
  bool isPasswordVisible = true;
  bool isSendOtp = false;
  bool isresendOtp = false;
  bool isremember = true;
  bool saveAttempted = false;
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD Email login page');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: _buildContent(context)),
      backgroundColor: Colors.grey[200],
    );
  }

  Future<void> resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(
          email: userController.text.trim().toString());
    } catch (e) {
      print(e);
    }
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: BackButton(),
              )),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 2,
                  ),
                  TextFormField(
                    cursorColor: Colors.black87,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      labelStyle: TextStyle(color: Colors.grey[800]),
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (textValue) {
                      setState(() {
                        userController.text = textValue.trim();
                      });
                    },
                    validator: (emailValue) {
                      if (emailValue.isEmpty) {
                        return 'enter text';
                      }
                      String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                          "\\@" +
                          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                          "(" +
                          "\\." +
                          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                          ")+";
                      RegExp regExp = new RegExp(p);

                      if (regExp.hasMatch(emailValue.trim())) {
                        // So, the email is valid
                        return null;
                      }

                      return 'invalid email address';
                    },
                    autofocus: false,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            cursorColor: Colors.black87,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                            obscureText: isPasswordVisible,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              // prefixIcon: Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              //   child: Icon(
                              //     Icons.security,
                              //     color: Colors.black87,
                              //   ),
                              // ),
                              labelText: 'password',
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                              ),
                              labelStyle: TextStyle(color: Colors.grey[800]),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(20),
                              hintText: 'password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (textValue) {
                              setState(() {
                                passwordController.text = textValue;
                              });
                            },
                            validator: (passwordValue) {
                              if (passwordValue.isEmpty) {
                                return 'enter text';
                              } else if (passwordValue.length < 8) {
                                return 'Please enter at least 8 character';
                              } else {
                                return null;
                              }
                            },
                            autofocus: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (userController.text.trim().isEmpty) {
                            Get.dialog(NotificationDialog(
                                title: 'error', content: 'enter text'));
                          } else if (!userController.text.trim().isEmail) {
                            Get.dialog(NotificationDialog(
                              title: 'error',
                              content:
                                  'AppLocalizations.of(context).invalid_emailaddress',
                            ));
                          } else {
                            Get.dialog(NotificationDialog(
                              title:
                                  'AppLocalizations.of(context).check_your_email',
                              content:
                                  'AppLocalizations.of(context).reset_pass_sent',
                            ));

                            resetPassword();

                            // Get.back();
                          }
                        },
                        child: Text(
                          'forgot password',
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SignInButton(
                    text: 'sign in',
                    onPressed: () {
                      setState(() {
                        saveAttempted = true;
                      });
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        signIn(context);
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 4,
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: userController.text.trim(), password: passwordController.text);
      if (user != null) {
        // print(_auth.currentUser.emailVerified);
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                EmailVerifyScreen(_auth.currentUser.emailVerified),
          ),
        );
      }
    } catch (err) {
      // print(err.code);
      if (err == 'ERROR_INVALID_EMAIL') {
        // isLoading = false;
        Get.dialog(NotificationDialog(
          title: 'error',
          content: 'invalid_emailaddress',
        ));
      }
      if (err == 'ERROR_WRONG_PASSWORD' || err == 'wrong-password') {
        Get.dialog(
            NotificationDialog(title: 'error', content: 'invalid password'));
      }
      if (err == 'ERROR_USER_NOT_FOUND' || err == 'user-not-found') {
        Get.dialog(NotificationDialog(
            title: 'error', content: 'email not registered'));
      }
    }
  }
}
