import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/wishview.dart';

class wishlist extends StatefulWidget {
  const wishlist({super.key});

  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewlist();
  }

  List<Map<String,dynamic>>?wish;

  final FirebaseFirestore _wishs=FirebaseFirestore.instance;

  viewlist()async {
    String usr = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot cartSnapshot = await _wishs
        .collection('user')
        .doc(usr)
        .collection('wishlist')
        .get();

    List<Map<String, dynamic>> loadedWish = [];

    for (var ucart in cartSnapshot.docs) {
      loadedWish.add(ucart.data() as Map<String, dynamic>);
    }

    setState(() {
      wish = loadedWish;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      body: wish==null
          ?Center(child: CircularProgressIndicator(),)

          :Column(
        children: [
          Expanded(
            child: wish!.isEmpty
                ? const Center(child: Text('No products found'))
                : ListView.builder(
              itemCount: wish!.length,
              itemBuilder: (context, index) {
                var product = wish![index];
                double M=double.tryParse(product['mrp'].toString()) ?? 00;
                double D=double.tryParse(product['discount'].toString()) ?? 00;

                double P=M*D/100;
                double F=M-P;


                return InkWell(
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Wishview(Wishlist: product)));

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
                                  '₹${F.toString()}',
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
