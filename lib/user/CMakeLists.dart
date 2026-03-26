import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/order.dart';
import 'package:shop/user/wishlist.dart';

  class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

  class _AccountState extends State<Account> {

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Viewpage();
  }


    Map<String,dynamic>?view;
  final FirebaseFirestore _userr=FirebaseFirestore.instance;

  Viewpage()async{

  String usr=FirebaseAuth.instance.currentUser!.uid;
  DocumentSnapshot doc=await _userr.collection('user').doc(usr).get();

  setState(() {
    view=doc.data() as Map<String,dynamic>?;
    if(view!=null){
      view!['id']=doc.id;
    }
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body:view==null
      ?Center(child: CircularProgressIndicator(),)

      :SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey.shade500,
                    child: Icon(Icons.account_circle,size: 150,color: Colors.black,),
                  )
                ),
                SizedBox(height: 10,),
                Text(view!['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                Text(view!['email'],style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),

        
            SizedBox(height: 20,),
        
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,blurRadius: 4,offset: Offset(0, 2)
                    )
                  ]
                ),

                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings,color: Colors.grey.shade800,),
                      title: Text('Settings'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: (){},
                    ),
                    ListTile(
                      leading: Icon(Icons.verified_user,color: Colors.blue,),
                      title: Text('My Orders'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>order()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.reviews,color: Colors.yellow.shade400,),
                      title: Text('My Reviews'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: (){},
                    ),
                  ],
                ),

              ),
            ),

            SizedBox(height: 10,),

            Text('Activity',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade50,blurRadius: 4,offset: Offset(0, 2)
                      )
                    ]
                ),

                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.favorite,color: Colors.red,),
                      title: Text('My Wishlist'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>wishlist()));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.history),
                      title: Text('Recently Viewed'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: (){},
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment_return),
                      title: Text('Returns'),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      onTap: (){},
                    ),
                  ],
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
