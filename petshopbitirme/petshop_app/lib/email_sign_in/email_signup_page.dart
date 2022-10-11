import 'package:firebase_auth/firebase_auth.dart';
import 'package:petshop_app/sign_in_button.dart';
import 'package:petshop_app/email_sign_in/email_verify.dart';
import 'package:petshop_app/email_sign_in/email_signup_page.dart';
import 'package:get/get.dart';
import 'package:petshop_app/notification_dialog.dart';
import 'email_login_page.dart';
import 'package:flutter/material.dart';

class EmailRegisterPage extends StatefulWidget {
  EmailRegisterPage();
  @override
  _EmailRegisterPageState createState() => _EmailRegisterPageState();
}

class _EmailRegisterPageState extends State<EmailRegisterPage>
    with SingleTickerProviderStateMixin {
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  bool isSendOtp = false;
  bool isresendOtp = false;
  bool isremember = true;
  final _auth = FirebaseAuth.instance;
  bool saveAttempted = false;
  final formKey = GlobalKey<FormState>();
  String passwordConfirm;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _showSignInError(BuildContext context, String errormessage) {
    AlertDialog(
      title: Text(errormessage),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD SignUpPage');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: _buildContent(context)),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Container()),
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
                        return 'please enter text';
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
                                return 'please enter text';
                              } else if (passwordValue.length < 8) {
                                return 'at least eight character';
                              } else {
                                return null;
                              }
                            },
                            autofocus: false,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          cursorColor: Colors.black87,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                          obscureText: isPasswordVisible2,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'confirm password',
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
                                    isPasswordVisible2 = !isPasswordVisible2;
                                  });
                                },
                                icon: Icon(
                                  isPasswordVisible2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'confirm password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (textValue) {
                            setState(() {
                              passwordConfirm = textValue;
                            });
                          },
                          validator: (pwConfirmValue) {
                            if (pwConfirmValue !=
                                passwordController.text.toString()) {
                              return 'passwords do not match';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SignInButton(
                    text: 'sign up',
                    onPressed: () {
                      setState(() {
                        saveAttempted = true;
                      });
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        signUp();
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'already registered?',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                //was replacement
                                builder: (BuildContext context) {
                                  return EmailLoginPage();
                                },
                              ));
                            },
                            child: Text(
                              'sign in',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Future<void> signUp() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: userController.text.trim().toString(),
              password: passwordController.text.toString())
          .then((_) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                EmailVerifyScreen(_auth.currentUser.emailVerified),
          ),
        );
      });
    } catch (err) {
      print("error code: ${err}");
      if (err == 'email-already-in-use' || err == 'EMAIL_ALREADY_IN_USE') {
        // isLoading = false;
        Get.dialog(NotificationDialog(
          title: 'error',
          content: 'email already in use',
        ));
      }
    }
  }
}
