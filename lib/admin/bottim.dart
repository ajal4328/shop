import 'package:flutter/material.dart';
import 'package:shop/admin/adminpage.dart';
import 'package:shop/admin/allpro.dart';
import 'package:shop/admin/users.dart';


class bottim extends StatefulWidget {
  const bottim({super.key});

  @override
  State<bottim> createState() => _bottimState();
}

class _bottimState extends State<bottim> {

  int _btm=0;

  var _neww=[
    pageadmin(),
    userss(),
    Allproduct(),
  ];
  void ww(int app){
    setState(() {
      _btm=app;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _neww.elementAt(_btm),

      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [

          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity_rounded,color: Colors.black,),label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: Colors.black,),label: 'Product'),
        ],
        currentIndex: _btm,
        onTap: ww,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}
