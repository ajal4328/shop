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

  List<QueryDocumentSnapshot> view=[];

  final FirebaseFirestore _carts=FirebaseFirestore.instance;

  viewcart()async {
    try {
      String usr = FirebaseAuth.instance.currentUser!.uid;
      print(usr);

      QuerySnapshot snapshot = await _carts
          .collection('cart')
          .where('uid', isEqualTo: usr)
          .orderBy('CreatedAt', descending: true)
          .get();

      // List<Map<String, dynamic>> loadedCart = [];

      print(snapshot.docs);
      print('hhhhhhhhh');


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

      appBar: AppBar(),

      body: view==false ?Center(child: CircularProgressIndicator(),)

          :Column(
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
                double P=0;
                P=M*D/100;


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
                                  '₹${P.toString()}',
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

    );
  }
}
