import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/bottomusr.dart';
import 'package:shop/user/userview.dart';
import 'package:shop/user/usrregister.dart';

class userpage extends StatefulWidget {
  const userpage({super.key});

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final _login=GlobalKey<FormState>();
  Loginn()async{

    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));

      Navigator.push(context, MaterialPageRoute(builder: (context)=>usrbottm()));
    }
    catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child:

          Center(
            child: Column(
              children: [

                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(

                      border: Border.all(color: Colors.black, width: 2),

                      gradient: LinearGradient(colors: [Colors.grey.shade400,Colors.white],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft
                      ),

                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(2, 4)
                      )]
                  ),
                  child: Icon(Icons.person,size: 50,),
                ),

                Text(
                  'Login',
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.2

                  ),),

                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(

                    color: Colors.white.withOpacity(0.85),
                    image: DecorationImage(
                        image: AssetImage("assets/ssp.jpg"),
                        fit: BoxFit.cover,
                        opacity: 0.5
                    ),


                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Form(
                    key: _login,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          TextFormField(

                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(

                              enabledBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.black,width: 2)
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),),

                              // filled: true,


                              fillColor: Colors.transparent,
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                              prefixIcon: Icon(Icons.email_rounded,color: Colors.black,),
                              border: OutlineInputBorder(),
                            ),

                            validator: (value) =>
                            value!.isEmpty ? 'Enter your email' : null,

                          ),

                          const SizedBox(height: 15),

                          TextFormField(

                            keyboardType: TextInputType.number,
                            controller: password,
                            obscureText: true,

                            decoration: const InputDecoration(

                              enabledBorder: OutlineInputBorder(
                                  borderSide:BorderSide(color: Colors.black,width: 2)
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),),


                              filled: true,
                              fillColor: Colors.transparent,

                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),
                              prefixIcon: Icon(Icons.password,color: Colors.black,),

                              border: OutlineInputBorder(),
                            ),

                            validator: (value) =>
                            value!.isEmpty ? 'Enter your password' : null,

                          ),

                          SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: Loginn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.7),
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                              ),
                              child:  Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Usercreat()));
                              },
                              child: const Text(

                                "Don't have an account? Register",

                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black

                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


