import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_search_bar/flutter_easy_search_bar.dart';

class userss extends StatefulWidget {
  const userss({super.key});

  @override
  State<userss> createState() => _userssState();
}

class _userssState extends State<userss> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Userspage();
  }  
  List<Map<String, dynamic>> usersList = [];
  Map<String,dynamic>?view;
  final FirebaseFirestore _users=FirebaseFirestore.instance;

  Userspage()async{

    QuerySnapshot snapshot = await _users.collection('user').get();

    setState(() {
      usersList = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });

  }
  String Searchvalue='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:EasySearchBar(
        backgroundColor: Colors.blue.shade300,
          title: Text('Users'),
          onSearch: (value)=>setState(() =>
          Searchvalue=value,

          ),
      ),
      body:   usersList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: usersList.length,
        itemBuilder: (context, index) {
          final user = usersList[index];

          final UsrNme=(user['name']??'').toString().toLowerCase();
          if(!UsrNme.contains(Searchvalue.toLowerCase())){
            return const SizedBox();
          }

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.shade100,
                child: Icon(Icons.person, size: 30, color: Colors.blue.shade700),
              ),
              title: Text(
                user['name'] ?? 'No Name',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                user['email'] ?? 'No Email',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),

            ),
          );
        },
      ),
    );
  }
}
