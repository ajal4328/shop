import 'package:flutter/material.dart';
import 'package:shop/user/CMakeLists.dart';
import 'package:shop/user/carts.dart';
import 'package:shop/user/userview.dart';
import 'package:shop/user/categories.dart';

class usrbottm extends StatefulWidget {
  const usrbottm({super.key});

  @override
  State<usrbottm> createState() => _usrbottmState();
}

class _usrbottmState extends State<usrbottm> {

  int _set=0;

  var _neww=[
    Userview(),
    Account(),
    Carts()
  ];

  void tt(int app){
setState(() {
  _set=app;
});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _neww.elementAt(_set),

      ),

      bottomNavigationBar: BottomNavigationBar(
          items: [

            BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,),label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.account_box,color: Colors.black,),label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: Colors.black,),label: 'Cart'),
          ],
        currentIndex: _set,
        onTap: tt,
      selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(decoration: TextDecoration.underline),
      ),

    );
  }



}
