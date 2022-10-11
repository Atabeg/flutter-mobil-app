import 'package:flutter/material.dart';
import 'package:petshop_app/email_sign_in/email_signup_page.dart';
import 'package:petshop_app/shared/baslik.dart';
import 'package:petshop_app/shared/hayvanList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  //was replacement
                  builder: (BuildContext context) {
                    return EmailRegisterPage();
                  },
                ));
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Text(
                      "Çıkış yap",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Icon(
                      Icons.exit_to_app,
                      size: 40,
                      color: Colors.red[800],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: Baslik(
                  text: " PetShop",
                ),
              ),
            ),
            Flexible(
              child: HayvanList(),
            ),
          ],
        ),
      ),
    );
  }
}
