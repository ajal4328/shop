import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/select.dart';

class pagectgy extends StatefulWidget {
  const pagectgy({super.key,required this.category});

  final String category;

  @override
  State<pagectgy> createState() => _pagectgyState();
}

class _pagectgyState extends State<pagectgy> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Viewcategory(widget.category);
  }



  List<QueryDocumentSnapshot> view=[];
  final FirebaseFirestore _category=FirebaseFirestore.instance;

  Future<void>Viewcategory(String category)async{

    List<Map<String,dynamic>>allcategory=[];

    try{

      QuerySnapshot snapshot = await _category
          .collection('product')
          .where('category', isEqualTo: category.toLowerCase())
          .orderBy('CreatedAt', descending: true)
          .get();
      setState(() {
        view = snapshot.docs;
      });

    }
    catch(e){
      print(e);
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text(
          widget.category,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2, 

      ),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2, // 👈 two items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 0.80,
          children: view.map((product) {

            double M=double.tryParse(product['mrp'].toString()) ?? 00;
            double D=double.tryParse(product['discount'].toString()) ?? 00;
            double P=0;
            P=M*D/100;

            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>viewpage(Product:product)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      child: Image.network(
                        product['uri'] ?? 'no image',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['name'] ?? 'No Name',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 5),
                          Text('₹${P.toString()}',
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),



    );
  }
}
