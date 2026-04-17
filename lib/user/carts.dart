import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/select.dart';

class Carts extends StatefulWidget {
  const Carts({super.key});

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewcart();
  }



  // bool isloading=true;

  List<QueryDocumentSnapshot> view=[];
  // List<QueryDocumentSnapshot> prdt=[];

  final FirebaseFirestore _carts=FirebaseFirestore.instance;

  viewcart()async {

    try {
      String usr = FirebaseAuth.instance.currentUser!.uid;
      print(usr);


      QuerySnapshot snapshot = await _carts
          .collection('cart')
          .where('user', isEqualTo: usr)
          // .orderBy('CreatedAt', descending: true)
          .get();

      print(snapshot.docs);
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      // List<Map<String, dynamic>> loadedCart = [];

      //
      // QuerySnapshot productshot = await _carts
      //     .collection('product')
      //     .orderBy('CreatedAt', descending: true)
      //     .get();
      //



      // print(productshot);
      print('ppppppppppppppppppppppppppppppppppppppp');

      setState(() {
        view = snapshot.docs;
        // prdt= productshot.docs;

      });
    }
    catch(e){
      print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');

      setState(() {
        // isloading=false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: view == false ?Center(child: CircularProgressIndicator(),)
          : view.isEmpty
          ? const Center(
            child: Text(
          "No Orders Found",
          style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            )
          : ListView.builder  (
            padding: const EdgeInsets.all(12),
            itemCount: view.length,
           itemBuilder: (context, index) {
            var product = view[index];
            var pid=product['product'];
            // var ppdetails=prdt[index];



            // String pid = orderDoc['product'];

             return FutureBuilder<DocumentSnapshot>(
             future: FirebaseFirestore.instance
              .collection('product')
             .doc(pid)
             .get(),
              builder: (context, snapshot) {
               if (!snapshot.hasData) {
              return const Padding(
              padding: EdgeInsets.all(20),
               child: Center(child: CircularProgressIndicator()),
               );
               }

               if (!snapshot.data!.exists) {
              return const SizedBox();
              }
               var p = snapshot.data!.data() as Map<String, dynamic>;

                double mrp = double.tryParse(p['mrp'].toString()) ?? 0;
                double discount = double.tryParse(p['discount'].toString()) ?? 0;
                double price = mrp - (mrp * discount / 100);



                return InkWell(
                onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                viewpage(Product: product)));

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
                            child: p['uri'] != null
                                ? Image.network(
                              p['uri'],
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
                                  p['name'] ?? 'No name',
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
                                  p['details'] ?? 'No details available',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  "₹$price",
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

          );


    },
    ));
  }
}
