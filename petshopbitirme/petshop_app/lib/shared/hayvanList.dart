import 'package:flutter/material.dart';
import 'package:petshop_app/Screens/detay.dart';
import '../models/hayvan.dart';

class HayvanList extends StatefulWidget {
  @override
  _HayvanListState createState() => _HayvanListState();
}

class _HayvanListState extends State<HayvanList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  List<Widget> _hayvanTiles = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  Tween<Offset> _offset = Tween(begin: Offset(1, 1), end: Offset(0, 0));

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addHayvan();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: _hayvanTiles.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
              child: _hayvanTiles[index], position: animation.drive(_offset));
        });
  }

  _addHayvan() {
    List<Hayvan> _hayvanlar = [
      Hayvan(
          ad: "Köpek maması",
          fiyat: "270",
          adet: "15",
          img: "kopek.mamasi.jpg"),
      Hayvan(
          ad: "Kedi oyuncağı", fiyat: "78", adet: "4", img: "kedi.oyuncak.jpg"),
      Hayvan(ad: "Balık yemi", fiyat: "50", adet: "50", img: "balik.yem.jpg"),
      Hayvan(
          ad: "Kedi maması", fiyat: "350", adet: "2", img: "kedi.mamasi.1.jpg"),
      Hayvan(
          ad: "Uzun tüylü kedi maması",
          fiyat: "297",
          adet: "8",
          img: "uzun.tuylu.jpg"),
      Hayvan(ad: "Kedi kumu", fiyat: "50", adet: "45", img: "kedi.kumu.jpg"),
      Hayvan(
          ad: "Balık akvaryumu",
          fiyat: "5000",
          adet: "19",
          img: "balik.akvaryum.jpg"),
      Hayvan(
          ad: "Kedi taşıma kabı",
          fiyat: "1500",
          adet: "1",
          img: "kedi.tasima.jpg"),
      Hayvan(ad: "Kuş yemi", fiyat: "400", adet: "10", img: "kus.yem.jpg"),
      Hayvan(
          ad: "Balık oltası", fiyat: "250", adet: "22", img: "balik.olta.jpg")
    ];
    Future ft = Future(() {});
    _hayvanlar.forEach((Hayvan h) {
      ft = ft.then((_) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          _hayvanTiles.add(_buildTile(h));
          _listKey.currentState.insertItem(_hayvanTiles.length - 1);
        });
      });
    });
  }

  Widget _buildTile(Hayvan h) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Detay(
            hayvan: h,
          );
        }));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${h.adet} adet",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          Text(
            h.ad,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 226, 66, 66)),
          ),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Hero(
            tag: 'img-${h.img}',
            child: Image.asset(
              'images/${h.img}',
              height: 50.0,
              width: 50.0,
            )),
      ),
      trailing: Text(
        '${h.fiyat} TL',
        style: TextStyle(color: Color.fromARGB(255, 32, 255, 81)),
      ),
    );
  }
}
