import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:petshop_app/models/hayvan.dart';
import 'package:petshop_app/shared/begen.dart';

class Detay extends StatefulWidget {
  final Hayvan hayvan;
  Detay({@required this.hayvan});
  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              child: Hero(
                tag: 'img-${widget.hayvan.img}',
                child: Image.asset(
                  'images/${widget.hayvan.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text(
                widget.hayvan.ad,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey[800]),
              ),
              subtitle: Text(
                '1 tane fiyatı ${widget.hayvan.fiyat} TL',
                style: TextStyle(letterSpacing: 1),
              ),
              trailing: Begen(),
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                "deneme",
                style: TextStyle(color: Colors.grey[600], height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
