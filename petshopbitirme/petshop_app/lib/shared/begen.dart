

import 'package:flutter/material.dart';


class Begen extends StatefulWidget {
  @override
  _BegenState createState() => _BegenState();
}

class _BegenState extends State<Begen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _renkAnimasyon;
  Animation _curve;
  bool favorite = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000)
    );

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    
    _renkAnimasyon = ColorTween(
     begin: Colors.grey[400],
     end: Colors.red, 
    ).animate(_curve);


    _controller.addListener(() {

    });


    _controller.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          favorite = true;
        });
      }else if(status == AnimationStatus.dismissed){
        favorite = false;
      }
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context,_){
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: _renkAnimasyon.value,
              size: 30,
            ),
            onPressed: (){
              favorite ? _controller.reverse():_controller.forward();
            },
          );
        }
    );
  }
}
