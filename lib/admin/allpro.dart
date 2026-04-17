import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/shop/prview.dart';

class Allproduct extends StatefulWidget {
  const Allproduct({super.key});

  @override
  State<Allproduct> createState() => _AllproductState();
}

   class _AllproductState extends State<Allproduct> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allview();
  }

  List<QueryDocumentSnapshot> view=[];

  final  FirebaseFirestore _allpro=FirebaseFirestore.instance;

  allview()async{
    try{

      QuerySnapshot snapshot=await _allpro.collection('product').orderBy('CreatedAt',descending: true).get();

      setState(() {
        view=snapshot.docs;
      });

    }catch(e){}

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          Expanded(
              child:
           view == false ?
          const Center(child: CircularProgressIndicator(),)
              :view.isEmpty
                  ? const Center(child: Text('NO PRODUCTS FOUND'),)

            : ListView.builder(

                  itemCount: view.length,
                  itemBuilder:(context,index){

                    var products=view[index];
                    double M=double.tryParse(products['mrp'].toString()) ?? 00;
                    double D=double.tryParse(products['discount'].toString()) ?? 00;

                    double P=M*D/100;
                    double F=M-P;

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

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: products['uri'] != null
                                    ? Image.network(
                                  products['uri'],
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
                                      products['name'] ?? 'No name',
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
                                      products['details'] ?? 'No details available',
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

                  } )
          )
        ],
      ),
    );
  }
}
