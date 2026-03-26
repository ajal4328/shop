import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop/prview.dart';

class Allreview extends StatefulWidget {
  // final Map<String, dynamic> product;
  final String product;
  const Allreview({super.key,required this.product});

  @override
  State<Allreview> createState() => _AllreviewState();
}

class _AllreviewState extends State<Allreview> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewreview();
  }

  List<QueryDocumentSnapshot>view=[];

  final FirebaseFirestore _review=FirebaseFirestore.instance;

  viewreview()async{

    print(widget.product);
    print("widget.product");

    try{
      String usr=FirebaseAuth.instance.currentUser!.uid;
      
      QuerySnapshot snapshot= await _review
          .collection('review')
      .where("product",isEqualTo: widget.product)
          // .orderBy('CreatedAt', descending: true)
          .get();

      setState(() {
        view=snapshot.docs;
        print(view);
        print("view");

      });

    }
    catch(e){}
  }

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
                var reviews = view[index];

                // double M=double.tryParse(product['product']['mrp'].toString()) ?? 00;
                // double D=double.tryParse(product['product']['discount'].toString()) ?? 00;
                //
                // double P=M*D/100;
                // double F=M-P;

                return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Viewpr(product: product),
                      //   ),
                      // );
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

                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: reviews['uri'] != null
                            //       ? Image.network(
                            //     product['uri'],
                            //     width: 100,
                            //     height: 100,
                            //     fit: BoxFit.cover,
                            //   )
                            //       : Container(
                            //     width: 100,
                            //     height: 100,
                            //     color: Colors.grey[200],
                            //     child: const Icon(Icons.shopping_bag, size: 40, color: Colors.grey),
                            //   ),
                            // ),

                            const SizedBox(width: 12),


                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    reviews['review'] ?? 'No review',
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
                                    "₹${reviews['rating'].toString()?? '0'}",
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
                    )
                );
              },
            ),
          ),





        ],
      ),
    );
  }
}
