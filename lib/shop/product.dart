import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop/addproduct.dart';
import 'package:shop/shop/prview.dart';
import 'package:shop/shop/seereview.dart';
import 'package:shop/shop/orderss.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewall();
  }

List<QueryDocumentSnapshot> view=[];


  // List<Map<String,dynamic>>?view=[];

  final FirebaseFirestore _product=FirebaseFirestore.instance;


viewall() async {
  try {
    String usr=FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot snapshot = await _product
        .collection('product')
        .where('uid',isEqualTo: usr)
        .orderBy('CreatedAt', descending: true)
        .get();

    setState(() {
      view = snapshot.docs;
    });

    print("Products fetched: ${view.length}");
  } catch (e) {
    print("Error fetching products: $e");
  }
}


// viewall()async{
//
//     // String usr=FirebaseAuth.instance.currentUser!.uid;
//     // QuerySnapshot prodct=await _product.collection('shopp').doc(usr).collection('Products')
//     //     .orderBy('CreatedAt', descending: false)
//     //     .get();
//     //
//     // List<Map<String, dynamic>> Products = prodct.docs
//     //     .map((doc) => doc.data() as Map<String, dynamic>).toList();
//
//
//     Future<List<QueryDocumentSnapshot>> fetchMyProducts() async {
//       String usr = FirebaseAuth.instance.currentUser!.uid;
//
//       print(usr);
//
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('product')
//           .where('uid', isEqualTo: usr)
//           .orderBy('CreatedAt', descending: true)
//           .get();
//
//       print(snapshot.docs);
//       print("hiii");
//
//       return snapshot.docs;
//     }
//
//
//       view = await fetchMyProducts();
//
//
//
//
//
//     // setState(() {
//     //   view=products;
//     // });
//
//     print('gggggggggggggg');
//     print(view);
//
//   }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: view.isEmpty
                ? const Center(child: Text('No products found'))
                : ListView.builder(
              itemCount: view.length,
              itemBuilder: (context, index) {
                var product = view[index];
                double M=double.tryParse(product['mrp'].toString()) ?? 00;
                double D=double.tryParse(product['discount'].toString()) ?? 00;

                double P=M*D/100;
                double F=M-P;

                 return InkWell(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => Viewpr(product: product),
                         ),
                       );
                     },

                 child: Card(
                  elevation: 4,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: product['uri'] != null
                              ? Image.network(
                            product['uri'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[200],
                            child: const Icon(Icons.shopping_bag, size: 40, color: Colors.grey),
                          ),
                        ),

                        const SizedBox(width: 12),


                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                product['name'] ?? 'No name',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 6),


                              Text(
                                product['details'] ?? 'No details available',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "₹${F.toString()?? '0'}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>addproduct()));

            },
            style: ElevatedButton.styleFrom(
              elevation: 6,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Add Product',
              style: TextStyle(fontSize: 14,color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
