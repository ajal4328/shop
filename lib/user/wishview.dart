import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wishview extends StatefulWidget {

  final Map<String,dynamic> Wishlist;

  const Wishview({super.key,required this.Wishlist});


  @override
  State<Wishview> createState() => _WishviewState();
}

class _WishviewState extends State<Wishview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  bool wishlisted=false;
  String? wishlistDocId;





  @override
  Widget build(BuildContext context) {



    final product = widget.Wishlist;

    double M=double.tryParse(product['mrp'].toString()) ?? 0;
    double D=double.tryParse(product['discount'].toString()) ?? 0;
    double P=M*D/100;
    double F=M-P;

    print(P);
    print(M);
    print(D);
    print('00000000000000000000000000000000');

    print(product['mrp']);
    print(product['discount']);



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


            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
                ],
              ),
              child: Image.network(
                product['uri'] ?? '',
                fit: BoxFit.contain,
              ),
            ),


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


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹${F.toString()}",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "₹${product['mrp'] ?? 'null'}",
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
                        child:  Text(
                          "${product['discount']}% Off",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),


                  if (product['details'] != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          product['details'],
                          style: const TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 10),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                      label: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[600],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: ()async{

                        String usr=FirebaseAuth.instance.currentUser!.uid;

                        await FirebaseFirestore.instance.collection("cart").add(
                            {
                              'user':usr,
                              'productId': product['id'],
                              'amount':F.toString(),
                              'status':'pending',
                              'CreatedAt': DateTime.now(),
                            });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to Cart")),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.flash_on, color: Colors.white),
                      label: const Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: ()async{

                        String usr=FirebaseAuth.instance.currentUser!.uid;

                        await FirebaseFirestore.instance.collection("order").add(
                            {
                              'user':usr,
                              'productId': product['id'],
                              'amount':F.toString(),
                              'status':'pending',
                              'CreatedAt': DateTime.now(),


                            });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Proceeding to Buy...")),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
