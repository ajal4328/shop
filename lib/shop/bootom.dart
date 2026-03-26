import 'package:flutter/material.dart';
import 'package:shop/shop/shoppage.dart';
import 'package:shop/shop/orderss.dart';
import 'package:shop/shop/product.dart';
class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {

  int _select=0;

  var _new=[
    shopp(),
    Orrders(),
    Products()
  ];
  
  void _tapp(int app){
    setState(() {
      _select=app;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _new.elementAt(_select),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled,color: Colors.black,),label:'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded,color: Colors.black,),label:'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.production_quantity_limits_sharp,color: Colors.black,),label:'Product'),
          ],
      currentIndex: _select,
        onTap: _tapp,
        selectedItemColor: Colors.black,
      ),
      
    );
  }
}
