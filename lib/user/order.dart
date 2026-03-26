import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/oredr%20select.dart';
import 'package:shop/user/select.dart';

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    vieworder();
  }

  List<QueryDocumentSnapshot>order=[];
  List<QueryDocumentSnapshot>product_col=[];

  final FirebaseFirestore _orderr=FirebaseFirestore.instance;

  vieworder()async {

    try {
      String usr = FirebaseAuth.instance.currentUser!.uid;

      print(usr);

      QuerySnapshot cartSnapshot = await _orderr
          .collection('order')
          .where('user', isEqualTo: usr)
          .orderBy('CreatedAt', descending: true)
          .get();

      print(cartSnapshot.docs);

      QuerySnapshot productSnapshot = await _orderr
          .collection('product')
          .orderBy('CreatedAt', descending: true)
          .get();




      print('gfghevfhgh');


      setState(() {
        order = cartSnapshot.docs;
        product_col = productSnapshot.docs;
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
        title: Text('My Orders'),
        centerTitle: true,
      ),

      body:  order == false ?
           const Center(child: CircularProgressIndicator())
          : order.isEmpty
          ? const Center(
        child: Text(
          "No Orders Found",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder  (
        padding: const EdgeInsets.all(12),
        itemCount: order.length,
        itemBuilder: (context, index) {
          var product = order[index];
          var pid=product['product'];
          var ppdetails=product_col[index];


    var orderDoc = order[index];
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

      print(snapshot.data);
      print("snapshot.dataaaaaaaaaaaaaaaaaaaaa");

      var p = snapshot.data!.data() as Map<String, dynamic>;

      double mrp = double.tryParse(p['mrp'].toString()) ?? 0;
      double discount = double.tryParse(p['discount'].toString()) ?? 0;
      double price = mrp - (mrp * discount / 100);


      // for()
      // for(var i in ppdetails.data()){
      //
      // }


      // double M=double.tryParse(ppdetails['mrp'].toString()) ?? 00;
      // double D=double.tryParse(ppdetails['discount'].toString()) ?? 00;
      // double P=0;
      // P=M*D/100;

      // return InkWell(
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => oselct(Product: product),
      //       ),
      //     );
      //   },
      //   child: Container(
      //     margin: const EdgeInsets.only(bottom: 15),
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(15),
      //       boxShadow: const [
      //         BoxShadow(
      //           color: Colors.black12,
      //           blurRadius: 6,
      //           offset: Offset(0, 3),
      //         ),
      //       ],
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(12),
      //       child: Row(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //
      //           // ClipRRect(
      //           //   borderRadius: BorderRadius.circular(12),
      //           //   child: ppdetails['uri'] != null
      //           //       ? Image.network(
      //           //     ppdetails['uri'],
      //           //     width: 100,
      //           //     height: 100,
      //           //     fit: BoxFit.cover,
      //           //   )
      //           //       : Container(
      //           //     width: 100,
      //           //     height: 100,
      //           //     color: Colors.grey[200],
      //           //     child: const Icon(Icons.shopping_bag,
      //           //         size: 40, color: Colors.grey),
      //           //   ),
      //           // ),
      //
      //           const SizedBox(width: 12),
      //
      //
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 // Text(product['product']),
      //                 // Text(product['amount']),
      //                 // Text(product['status']),
      //                 // Text(product['CreatedAt'].toString()),
      //
      //                 // Text(
      //                 //   ppdetails['name'] ?? "No Name",
      //                 //   style: const TextStyle(
      //                 //     fontSize: 18,
      //                 //     fontWeight: FontWeight.w700,
      //                 //   ),
      //                 //   maxLines: 1,
      //                 //   overflow: TextOverflow.ellipsis,
      //                 // ),
      //
      //                 const SizedBox(height: 6),
      //
      //
      //                 // Text(
      //                 //   ppdetails['details'] ??
      //                 //       "No details available",
      //                 //   style: const TextStyle(
      //                 //     fontSize: 14,
      //                 //     color: Colors.black54,
      //                 //   ),
      //                 //   maxLines: 2,
      //                 //   overflow: TextOverflow.ellipsis,
      //                 // ),
      //
      //                 const SizedBox(height: 10),
      //
      //
      //                 // Row(
      //                 //   mainAxisAlignment:
      //                 //   MainAxisAlignment.spaceBetween,
      //                 //   children: [
      //                 //     Text(
      //                 //       "₹$P",
      //                 //       style: const TextStyle(
      //                 //           fontSize: 18,
      //                 //           fontWeight: FontWeight.bold,
      //                 //           color: Colors.green),
      //                 //     ),
      //                 //
      //                 //
      //                 //     Container(
      //                 //       padding: const EdgeInsets.symmetric(
      //                 //           horizontal: 12, vertical: 4),
      //                 //       decoration: BoxDecoration(
      //                 //         color: Colors.blue.shade100,
      //                 //         borderRadius:
      //                 //         BorderRadius.circular(20),
      //                 //       ),
      //                 //       child: const Text(
      //                 //         "Ordered",
      //                 //         style: TextStyle(
      //                 //             fontSize: 13,
      //                 //             color: Colors.blue),
      //                 //       ),
      //                 //     ),
      //                 //   ],
      //                 // )
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      return InkWell(
        onTap: () {


          print(pid);
          print("ppppppppppppppppppppppppppppppppp");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => oselct(Product: p,Productid: pid,),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  p['uri'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      p['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      p['details'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "₹$price",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            orderDoc['status'],
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    );

        },
      ),

    );
  }
}
