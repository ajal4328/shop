import 'package:flutter/material.dart';

class shopp extends StatefulWidget {
  const shopp({super.key});

  @override
  State<shopp> createState() => _shoppState();
}

class _shoppState extends State<shopp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child:
          Column(
            children: [

              Container(
                height: 500,
                width: 370,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 3),
                  image:DecorationImage(image: AssetImage("assets/shop.jpg"))
                ),
              ),

              Container(
                decoration: BoxDecoration(),
              )
            ],
          ),
        ),
      ),

    );
  }
}
