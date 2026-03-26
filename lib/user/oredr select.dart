import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop/product.dart';

class oselct extends StatefulWidget {

  final Map<String, dynamic> Product;
  final String Productid;

  const oselct({super.key,required this.Product,required this.Productid});


  @override
  State<oselct> createState() => _viewpageState();
}

class _viewpageState extends State<oselct> {


  int _rating = 3; // Tracks the selected rating (0 to 5)

  // Function to handle star tap
  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkWishlist();
  }

  bool wishlisted=false;
  String? wishlistDocId;

  TextEditingController review = TextEditingController();


  checkWishlist() async {
    String usr = FirebaseAuth.instance.currentUser!.uid;
    final product = widget.Product;

    print(product);
    print("ppppppp");

    // QuerySnapshot snap = await FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(usr)
    //     .collection('wishlist')
    //     .where('name', isEqualTo: product['name'])
    //     .get();

    // if (snap.docs.isNotEmpty) {
    //   setState(() {
    //     wishlisted = true;
    //     wishlistDocId = snap.docs.first.id;
    //   });
    // }
  }


  @override
  Widget build(BuildContext context) {






    final product = widget.Product;


    // var pid=product['product'];
    // var ppdetails=product_col[index];
    //
    //
    // var orderDoc = order[index];
    // String pid = orderDoc['product'];

    // return FutureBuilder<DocumentSnapshot>(
    //     future: FirebaseFirestore.instance
    //     .collection('product')
    //     .doc(pid)
    //     .get(),
    // builder: (context, snapshot) {
    //   if (!snapshot.hasData) {
    //     return const Padding(
    //       padding: EdgeInsets.all(20),
    //       child: Center(child: CircularProgressIndicator()),
    //     );
    //   }
    //
    //   if (!snapshot.data!.exists) {
    //     return const SizedBox();
    //   }
    //
    //   var p = snapshot.data!.data() as Map<String, dynamic>;
    //
      double mrp = double.tryParse(product['mrp'].toString()) ?? 0;
      double discount = double.tryParse(product['discount'].toString()) ?? 0;
      double price = mrp - (mrp * discount / 100);


      double M = double.tryParse(product['mrp'].toString()) ?? 00;
      double D = double.tryParse(product['discount'].toString()) ?? 00;
      double P = 0;
      P = M * D / 100;

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
          // foregroundColor: Colors.black,
          elevation: 2,

          actions: [
            // IconButton(
            //     onPressed: () async {
            //       String usr = FirebaseAuth.instance.currentUser!.uid;
            //
            //       if (wishlisted) {
            //         await FirebaseFirestore.instance
            //             .collection('user')
            //             .doc(usr)
            //             .collection('wishlist')
            //             .doc(wishlistDocId)
            //             .delete();
            //         setState(() {
            //           wishlisted = false;
            //           wishlistDocId = null;
            //         });
            //
            //         ScaffoldMessenger.of(context).showSnackBar(
            //             const SnackBar(content: Text("Remove to Wishlist")));
            //       }
            //
            //       else {
            //         DocumentReference prowish = await FirebaseFirestore.instance
            //             .collection('user')
            //             .doc(usr)
            //             .collection("wishlist")
            //             .add(
            //             {
            //               'uri': product['uri'],
            //               'name': product['name'],
            //               'amount': P.toString(),
            //               'details': product['details'],
            //               'discount': product['discount'],
            //               'mrp': product['mrp'],
            //             });
            //         setState(() {
            //           wishlisted = true;
            //           wishlistDocId = prowish.id;
            //         });
            //         ScaffoldMessenger.of(context).showSnackBar(
            //             const SnackBar(content: Text("Added to Wishlist")));
            //       }
            //     },
            //
            //     icon: Icon(Icons.favorite, color: Colors.red))
          ],

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
                    BoxShadow(color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3))
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
                        Text("4.3", style: TextStyle(
                            fontWeight: FontWeight.w600)),
                      ],
                    ),

                    const SizedBox(height: 15),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${price??'null'}",
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "${product['discount']}% Off",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
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
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              Card(
                elevation: 6,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 40,
                            ),
                            onPressed: () => _setRating(index + 1),
                          );
                        }),
                      ),

                      TextField(
                        controller: review,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Write your review...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.blue,
                          // button color
                          foregroundColor: Colors.white,
                          // text color
                          elevation: 6,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        onPressed: () async {
                          if (review.text
                              .trim()
                              .isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please write a review")),
                            );
                            return;
                          }

                          print(review.text);

                          String ord = FirebaseAuth.instance.currentUser!.uid;


                          print(widget.Product);
                          print('jjjjjjjjjjjjjjjjjjjjjjj');

                          await FirebaseFirestore.instance.collection('review')
                              .add({
                            'review': review.text,
                            'oredrid': ord,
                            'product':widget.Productid,
                            'CreatedAt': DateTime.now(),
                            'rating': _rating,
                          });

                          review.clear();
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              )


            ],
          ),
        ),

      );
    }

}
