import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop/bootom.dart';
import 'package:shop/shop/registr.dart';


class Shoppage extends StatefulWidget {
  const Shoppage({super.key});

  @override
  State<Shoppage> createState() => _ShoppageState();
}

class _ShoppageState extends State<Shoppage> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final _Shopp=GlobalKey<FormState>();

  Login() async {
    try {
      // Step 1: Sign in with Firebase Auth
      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      String uid = userCred.user!.uid;

      // Step 2: Check if shop document exists in Firestore
      DocumentSnapshot shopDoc = await FirebaseFirestore.instance
          .collection('shopp')
          .doc(uid)
          .get();

      if (shopDoc.exists) {
        // Admin exists → allow login
        if (shopDoc.exists && shopDoc['status'] == 'accepted') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Shop Login Success')),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Bottom()),
          );
        }
        else if(shopDoc.exists && shopDoc['status'] == 'pending'){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Shop not accepted')),
          );
          FirebaseAuth.instance.signOut();
        }

      } else {
        // Admin not found → deny login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Shop id not match')),
        );

        FirebaseAuth.instance.signOut(); // Logout the user
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        image: AssetImage("assets/shop.jpg"),
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
                    key: _Shopp,
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
                              prefixIcon: Icon(Icons.visibility_off,color: Colors.black,),

                              border: OutlineInputBorder(),
                            ),

                            validator: (value) =>
                            value!.isEmpty ? 'Enter your password' : null,

                          ),

                          SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: Login,
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
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Registerr()));
                    },
                    child: Text('Registor'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
