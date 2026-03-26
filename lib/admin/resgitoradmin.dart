import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class regiadmin extends StatefulWidget {
  const regiadmin({super.key});

  @override
  State<regiadmin> createState() => _regiadminState();
}

class _regiadminState extends State<regiadmin> {

  final _readmin=GlobalKey<FormState>();

  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  final FirebaseFirestore _regstrad=FirebaseFirestore.instance;

  Regiter()async{
    if(!_readmin.currentState!.validate())return;

    try{
      UserCredential userCred=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      await _regstrad.collection('admin').doc(userCred.user!.uid).set({

        'name':name.text,
        'age':age.text,
        'number':number.text,
        'email':email.text,
        'CreatedAt': FieldValue.serverTimestamp(),

      });

      ScaffoldMessenger.of(context)..showSnackBar(
          SnackBar(content: Text('Success'))
      );
      name.clear();
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
              const SizedBox(height: 40),
              Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.blueAccent.shade700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 3,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.blueGrey.shade100, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 3,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _readmin,
                  child: Column(
                    children: [


                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          labelText: 'Enter Name',
                          prefixIcon: const Icon(Icons.person_outline),
                          filled: true,
                          fillColor: Colors.blue.shade50.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter your name' : null,
                      ),
                      const SizedBox(height: 15),


                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: age,
                        decoration: InputDecoration(
                          labelText: 'Enter Age',
                          prefixIcon: const Icon(Icons.calendar_today_outlined),
                          filled: true,
                          fillColor: Colors.blue.shade50.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter your age' : null,
                      ),
                      const SizedBox(height: 15),


                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: number,
                        decoration: InputDecoration(
                          labelText: 'Enter Number',
                          prefixIcon: const Icon(Icons.phone_android_outlined),
                          filled: true,
                          fillColor: Colors.blue.shade50.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter your number' : null,
                      ),
                      const SizedBox(height: 15),


                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Enter Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          filled: true,
                          fillColor: Colors.blue.shade50.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter your email' : null,
                      ),
                      const SizedBox(height: 15),


                      TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          labelText: 'Enter Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          filled: true,
                          fillColor: Colors.blue.shade50.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter your password' : null,
                      ),
                      const SizedBox(height: 30),


                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: Regiter,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.blueAccent,
                            shadowColor: Colors.blueAccent.withOpacity(0.4),
                            elevation: 8,
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
