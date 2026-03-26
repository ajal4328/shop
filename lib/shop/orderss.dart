import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop/prview.dart';
import 'package:shop/shop/seereview.dart';

class Orrders extends StatefulWidget {
  const Orrders({super.key});

  @override
  State<Orrders> createState() => _OrrdersState();
}

class _OrrdersState extends State<Orrders> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderr();
  }

  
  // List<QueryDocumentSnapshot> views=[];
  List<QueryDocumentSnapshot> pview=[];
  List<QueryDocumentSnapshot> orderdproducts=[];
  //
  //
  //
  final FirebaseFirestore _order=FirebaseFirestore.instance;
  //
  // orderr() async {
  //   try {
  //
  //     String usr=FirebaseAuth.instance.currentUser!.uid;
  //
  //     QuerySnapshot ordershot = await _order
  //         .collection('review')
  //         .orderBy('CreatedAt', descending: true)
  //         .get();
  //
  //     print(ordershot);
  //     print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
  //     QuerySnapshot products=await _order.collection('product')
  //         .where('uid', isEqualTo: usr)
  //         .orderBy('CreatedAt', descending: true).get();
  //
  //     for(var i in products.docs){
  //       QuerySnapshot pviewshot=await _order.collection('order')
  //           .where('product',isEqualTo: i['product'])
  //           .orderBy('CreatedAt', descending: true).get();
  //
  //       print(pviewshot);
  //       print('oooooooooooooooooooooooooooooo');
  //
  //       setState(() {
  //         views = ordershot.docs;
  //         pview=pviewshot.docs;
  //         // orderdproducts details ="";
  //         // userdetails
  //
  //       });
  //     }
  //
  //
  //
  //
  //
  //     print(pview);
  //     print('nvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
  //
  //
  //
  //
  //     print("Products fetched: ${views.length}");
  //   } catch (e) {
  //     print("Error fetching products: $e");
  //   }
  //
  // }



  List<Map<String, dynamic>> views = [];

  orderr() async {
    try {
      String usr = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot orderSnap = await _order
          .collection('order')
          .orderBy('CreatedAt', descending: true)
          .get();

      List<Map<String, dynamic>> temp = [];

      for (var orderDoc in orderSnap.docs) {
        var orderData = orderDoc.data() as Map<String, dynamic>;


        String userId = orderData['user'];

        //  Get user
        DocumentSnapshot usersnap = await _order
            .collection('user')
            .doc(userId)
            .get();


        String productId = orderData['product'];

        //  Get product
        DocumentSnapshot productSnap = await _order
            .collection('product')
            .doc(productId)
            .get();

        if (!productSnap.exists) continue;

        var productData = productSnap.data() as Map<String, dynamic>;

        //  Filter: only current seller's products
        if (productData['uid'] == usr) {
          temp.add({
            'order': orderData,
            'product': productData,
            'user': usersnap,
          });
        }
      }

      setState(() {
        views = temp;
      });

      print("Filtered Orders: $views");

    } catch (e) {
      print("Error: $e");
    }
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: views.isEmpty
                ? const Center(child: Text('No products found'))
                : ListView.builder(
              itemCount: views.length,
              itemBuilder: (context, index) {
                var prdct = views[index];

                double M=double.tryParse(prdct['product']['mrp'].toString()) ?? 00;
                double D=double.tryParse(prdct['product']['discount'].toString()) ?? 00;

                double P=M*D/100;
                double F=M-P;

                return Card(
                  elevation: 4,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: prdct['product']['uri'] != null
                              ? Image.network(
                            prdct['product']['uri'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[200],
                            child: const Icon(Icons.shopping_bag,
                                size: 40, color: Colors.grey),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Row(
                                children: [
                                  const Icon(Icons.person, size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      "Ordered by: ${prdct['user']['name'] ?? 'User'}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),


                              Text(
                                prdct['product']['name'] ?? 'No name',
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
                                prdct['product']['details'] ?? 'No details available',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    "₹${F.toString() ?? '0'}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),

                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 3,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Allreview(
                                              product: prdct['order']['product']),
                                        ),
                                      );
                                    },
                                    child: const Text("See Reviews"),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),

    );
  }
}
