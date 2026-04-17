import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/user/categorypage.dart';
import 'package:shop/user/select.dart';

class Userview extends StatefulWidget {
  const Userview({super.key});

@override
  State<Userview> createState() => _UserviewState();
}

class _UserviewState extends State<Userview> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllProducts();
    seaching.addListener(search);
  }


  // List<Map<String,dynamic>>?view=[];

  List<QueryDocumentSnapshot> view=[];



  TextEditingController seaching=TextEditingController();

  List Filtoproduct=[];



  final FirebaseFirestore _product = FirebaseFirestore.instance;

  double P=0;
  Future<void> loadAllProducts() async {
    List<Map<String, dynamic>> allProducts = [];

    try {

      // QuerySnapshot shopsSnapshot = await _product.collection('shopp').get();
      //
      //
      // for (var shopDoc in shopsSnapshot.docs) {
      //
      //   QuerySnapshot productsSnapshot = await _product
      //       .collection('product')
      //       .get();
      //
      //
      //   for (var prod in productsSnapshot.docs) {
      //     allProducts.add(prod.data() as Map<String, dynamic>);
      //   }
      // }

      QuerySnapshot snapshot = await _product
          .collection('product')
          .orderBy('CreatedAt', descending: true)
          .get();


      setState(() {
        view = snapshot.docs;
        Filtoproduct=allProducts;
      });

      print("✅ All Products: ${allProducts}");


    } catch (e) {
      print("⚠️ Error fetching products: $e");
    }


  }

  search(){
   final quary=seaching.text.toLowerCase();

   setState(() {
     Filtoproduct=view!.where((item){
       final c= item as Map<String,dynamic>;
       final name=c['name']?.toString().toLowerCase()??'';
       return name.contains(quary);
     }).toList();
   });

   }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: seaching,
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.camera_alt_outlined),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child:  SingleChildScrollView(
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: 'fashion')));
                              },
                              child:
                              Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage: NetworkImage('https://i2.wp.com/attireclub.org/wp-content/uploads/2016/04/Solid-Shirt-and-Pants.png?resize=500%2C500&ssl=1'),),
                                  Text('Fashion',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(

                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: 'beauty')));
                              },
                              child: Column(
                                children: [

                                  CircleAvatar(radius: 30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th?q=Beauty+Products+PNG&w=120&h=120&c=1&rs=1&qlt=70&o=7&cb=1&dpr=1.3&pid=InlineBlock&rm=3&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),),
                                  Text('Beauty',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: 'grocery')));
                              },
                              child: Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.L0wWBfTcwEfK5q4BKveN9QHaGl?w=165&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3'),),
                                  Text('Grocery',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: 'gadgets')));
                              },
                              child: Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.ZLUCaUs7HyXc-rRJooDaVgHaFO?w=262&h=186&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3'),),
                                  Text('Gadgets',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: 'appliances')));
                              },
                              child: Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage : NetworkImage('https://th.bing.com/th/id/OIP.d1pb2oqZOQljduQPpA_x0AHaFk?w=241&h=181&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3'),),
                                  Text('Appliances',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: 'eletronic')));
                              },
                              child: Column(
                                children: [

                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th?q=Home+Appliances+and+Electronics+Image&w=120&h=120&c=1&rs=1&qlt=70&o=7&cb=1&dpr=1.3&pid=InlineBlock&rm=3&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),),
                                  Text('Eletronic',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: "toys",)));

                              },
                              child:
                              Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th?q=Disney+Junior+Toys&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),),
                                  Text('Toys',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),
                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: "mobiles",)));

                              },
                              child:
                              Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th?q=Mobile+iPhone+15&w=120&h=120&c=1&rs=1&qlt=70&o=7&cb=1&dpr=1.3&pid=InlineBlock&rm=3&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),),
                                  Text('Mobiles',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),

                            SizedBox(width: 25,),

                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>pagectgy(category: "sports",)));
                              },
                              child:
                              Column(
                                children: [

                                  CircleAvatar(
                                    radius:30,
                                    backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.QX44ZZgxXGgh5DWuk0nxBQHaFm?w=247&h=187&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3'),),
                                  Text('Sports',style: TextStyle(fontWeight: FontWeight.bold),),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2, // 👈 two items per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.75,
                      children: view.map((product) {

                        double M=double.tryParse(product['mrp'].toString()) ?? 00;
                        double D=double.tryParse(product['discount'].toString()) ?? 00;

                        double P=M*D/100;
                        double F=M-P;

                        print(P);
                        print(M);
                        print(D);
                        print('00000000000000000000000000000000');

                        print(product['mrp']);
                        print(product['discount']);


                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>viewpage(Product:product)));
                          },
                          child:Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // image
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  child: Image.network(
                                    product['uri'] ?? 'no image',
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                  scrollDirection:Axis.horizontal,
                                        child: Text(product['name'] ?? 'No Name',
                                            style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      ),
                                      SizedBox(height: 5),

                                      Text("₹${F.toString()?? '0'}",
                                          style: TextStyle(color: Colors.green)),

                                      SizedBox(height: 5,),


                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 10, // 👈 give it a fixed height
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal, // 👈 make it horizontal
                                                itemCount: 4,
                                                itemBuilder: (context, index) {
                                                  return const Icon(Icons.star, color: Colors.amber);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                  ],
                ),
            ),
            ),





        ],
      ),
    );
  }
}
