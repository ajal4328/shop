import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registerr extends StatefulWidget {
  const Registerr({super.key});

  @override
  State<Registerr> createState() => _RegisterrState();
}

class _RegisterrState extends State<Registerr> {

  final _regist=GlobalKey<FormState>();

  TextEditingController shopname=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  final FirebaseFirestore _register=FirebaseFirestore.instance;

  Regiter()async{
    if(!_regist.currentState!.validate())return;

    try{
      UserCredential userCred=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());


      await _register.collection('shopp').doc(userCred.user!.uid).set({

        'shop name':shopname.text,
        'name':username.text,
        'age':age.text,
        'number':number.text,
        'email':email.text,
        'status':'pending',
        'CreatedAt': FieldValue.serverTimestamp(),
        
      });
      
      ScaffoldMessenger.of(context)..showSnackBar(
        SnackBar(content: Text('Success'))
      );
      shopname.clear();
      username.clear();
      age.clear();
      number.clear();
      email.clear();
      password.clear();

    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('Registor',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 8,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
                child: Form(
                  key: _regist,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Name
                        TextFormField(
                          controller:shopname,
                          decoration: InputDecoration(
                            labelText: 'Enter Shop Name',
                            prefixIcon: Icon(Icons.store),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Enter your name' : null,
                        ),
                        SizedBox(height: 15),

                        TextFormField(
                          controller:username,
                          decoration: InputDecoration(
                            labelText: 'Enter Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Enter your name' : null,
                        ),
                        SizedBox(height: 15),

                        // Age
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: age,
                          decoration: InputDecoration(
                            labelText: 'Enter Age',
                            prefixIcon: Icon(Icons.perm_identity),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Enter your age' : null,
                        ),
                        SizedBox(height: 15),

                        // Number
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: number,
                          decoration: InputDecoration(
                            labelText: 'Enter number',
                            prefixIcon: Icon(Icons.numbers),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Enter your number' : null,
                        ),
                        SizedBox(height: 15),

                        // Email
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Enter email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Enter your email' : null,
                        ),
                        SizedBox(height: 15),

                        // Password
                        TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value!.isEmpty ? 'Enter your password' : null,
                        ),
                        SizedBox(height: 25),

                        // Register Button
                        ElevatedButton(
                          onPressed: Regiter,
                          style: ElevatedButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
