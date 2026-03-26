import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Viewpr extends StatefulWidget {
  final QueryDocumentSnapshot product;

  const Viewpr({super.key, required this.product});

  @override
  State<Viewpr> createState() => _ViewprState();
}

class _ViewprState extends State<Viewpr> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    viewpdct();
  }

  List<QueryDocumentSnapshot>view=[];

  final FirebaseFirestore _pdct=FirebaseFirestore.instance;

  viewpdct()async{
    try{

      String usr=FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot snapshot = await _pdct
          .collection('review')
          .where('product_id',isEqualTo:widget.product.id )
          .orderBy('CreatedAt', descending: true)
          .get();


      setState(() {
        view=snapshot.docs;
      });

      print('hhhhhhhhhhhhhhhhhhhhhhhhhh');
    }

      catch(e){print("Error fetching products: $e");}
  }

  Widget build(BuildContext context) {
    final product = widget.product;

    double M=double.tryParse(product['mrp'].toString()) ?? 00;
    double D=double.tryParse(product['discount'].toString()) ?? 00;

    double P=M*D/100;
    double F=M-P;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product['name'] ?? 'Product Details',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Product Image
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Image.network(
                product['uri'] ?? '',
                fit: BoxFit.contain,
              ),
            ),

            // Details
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    product['name'] ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Rating
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      Icon(Icons.star_half, color: Colors.amber, size: 22),
                      Icon(Icons.star_outline, color: Colors.amber, size: 22),
                      SizedBox(width: 8),
                      Text("4.3", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${F.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "₹$M",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "$D% Off",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  if (product['details'] != null) ...[
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product['details'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ],
              ),
            ),

            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: view.length,
                itemBuilder: (context, index) {
                  var review = view[index];
                  return ListTile(
                    title: Text(review['review'] ?? ''),
                  );
                },
              ),
            ),



          ],
        ),
      ),
    );
  }
}
