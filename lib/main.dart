import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/admin/page2.dart';
import 'package:shop/firebase_options.dart';
import 'package:shop/shop/shop.dart';
import 'package:shop/splash.dart';
import 'package:shop/user/pagee.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
);
  runApp(Main());
}
class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  bool _isuser = false;
  bool _isadmin = false;
  bool _isshop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Stack(
          children: [
            Positioned.fill(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/hit.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.3),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ), ),

            Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Expanded(
                              child:Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient:LinearGradient(
                                        colors: [Colors.white.withOpacity(0.9,),
                                          Colors.white.withOpacity(0.6),
                                        ],
                                    ),

                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: Offset(0,6),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [

                                      Icon(Icons.person, size: 42, color: Colors.blueAccent),

                                      SizedBox(height: 8),

                                      Text(
                                        "User",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),

                                      SizedBox(height: 8),

                                      Checkbox(
                                        value: _isuser,
                                        onChanged: (val){
                                          setState(() {
                                            _isuser = val!;
                                            if(_isuser){
                                              _isadmin = false;
                                              _isshop = false;
                                            }
                                          });
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ),

                            Expanded(
                              child: Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0,4),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [

                                      Icon(Icons.admin_panel_settings, size: 42, color: Colors.redAccent),

                                      SizedBox(height: 8),

                                      Text(
                                        "Admin",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),

                                      SizedBox(height: 8),

                                      Checkbox(
                                        value: _isadmin,
                                        onChanged: (val){
                                          setState(() {
                                            _isadmin = val!;
                                            if(_isadmin){
                                              _isuser = false;
                                              _isshop = false;
                                            }
                                          });
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ),

                            Expanded(
                              child: Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(0,4),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [

                                      Icon(Icons.store_mall_directory_outlined, size: 42, color: Colors.green),

                                      SizedBox(height: 8),

                                      Text(
                                        "Shop",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),

                                      SizedBox(height: 8),

                                      Checkbox(
                                        value: _isshop,
                                        onChanged: (val){
                                          setState(() {
                                            _isshop = val!;
                                            if(_isshop){
                                              _isadmin = false;
                                              _isuser = false;
                                            }
                                          });
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ),

                          ],
                        )
                      ),

                      ElevatedButton(
                          onPressed: (){
                            if(_isuser){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>userpage()));
                            }
                            else if(_isadmin){

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin()));
                            }
                            else if(_isshop){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Shoppage()));
                            }

                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content:
                                  Text('Please select an option before continuing')
                                  ));
                            }

                          },
                          style: ElevatedButton.styleFrom(
                           padding: EdgeInsets.symmetric(horizontal: 70,vertical: 16),
                           elevation: 10,
                           shape:RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(40),
                           ),
                          ),

                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.white,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: BoxConstraints(minWidth: 150, minHeight: 45),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                )
            )
          ],
        ),
    );
  }
}
