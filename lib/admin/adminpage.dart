import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_search_bar/flutter_easy_search_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';


class pageadmin extends StatefulWidget {
  const pageadmin({super.key});

  @override
  State<pageadmin> createState() => _pageadminState();
}

class _pageadminState extends State<pageadmin> {

  TextEditingController seaching=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shoppage();
  }

  
  
  List<Map<String,dynamic>> shoplist=[];
  Map<String,dynamic>? view;
  final FirebaseFirestore _shops=FirebaseFirestore.instance;
  
  shoppage()async{
    QuerySnapshot snapshot=await _shops.collection('shopp').get();

    setState(() {
      shoplist=snapshot.docs.map((doc){
        final data=doc.data() as Map<String,dynamic>;
        data['id']=doc.id;
        return data;
      }).toList();
    });

  }

  String searchValue = '';
  final List<String> _suggestions = ['Accepted', 'Pending', 'Rejected',];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        backgroundColor: Colors.blue.shade300,
          title: const Text('Home'),
          onSearch: (value) => setState(() => searchValue = value),
          suggestions: _suggestions

      ),

      body:shoplist.isEmpty
        ?const Center(child: CircularProgressIndicator())

     : Column(
       children: [
         // SizedBox(height: 20,),
         // Padding(
         //   padding: const EdgeInsets.all(5),
         //   child: TextFormField(
         //     controller: seaching,
         //     decoration: InputDecoration(
         //       hintText: 'Search products...',
         //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
         //       prefixIcon: const Icon(Icons.search),
         //
         //       filled: true,
         //       fillColor: Colors.white,
         //     ),
         //   ),
         // ),

         Expanded(
           child: ListView.builder(

              padding: const EdgeInsets.all(10),
               itemCount: shoplist.length,
               itemBuilder: (context, index) {
            final shp = shoplist[index];

            // final shopName = (shp['shop name'] ?? '').toString().toLowerCase();
            // final shoppName = (shp['status'] ?? '').toString().toLowerCase();
            //
            //
            //
            // if (!shopName.contains(searchValue.toLowerCase())
            //     && !shoppName.contains(searchValue)) {
            //
            // }

            final shopName = (shp['shop name'] ?? '').toString().toLowerCase();
            final status = (shp['status'] ?? '').toString().toLowerCase();
            final query = searchValue.toLowerCase();
            print(query);


                 if (query.isNotEmpty &&
                     !shopName.contains(query) &&
                     !status.contains(query)) {
                   return const SizedBox();
                 }
           

            return

              Column(
                children: [
                  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(Icons.storefront, size: 30, color: Colors.blue.shade700),
                    ),
                    title: Text(
                      shp['shop name'] ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),

                    ),
                    subtitle: Text(
                      shp['name'] ?? 'No Owner',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),



                    trailing: shp['status']=="pending"?Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [


                        ElevatedButton(
                          onPressed: () {




                            _shops.collection("shopp").doc(shp['id']).update({"status": "accepted"});

                            Fluttertoast.showToast(msg: "Acccepted");

                            shoppage();

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Accept',style: TextStyle(color: Colors.black,),),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                          onPressed: () {


                            _shops.collection("shopp").doc(shp['id']).update({"status": "Rejected"});

                            Fluttertoast.showToast(msg: "Rejected");

                            shoppage();


                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Reject',style: TextStyle(color: Colors.black,),),
                        ),
                      ],
                    ):Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: shp['status'] == "accepted"
                            ? Colors.green.shade100
                            : shp['status'] == "Rejected"
                            ? Colors.red.shade100
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        shp['status'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: shp['status'] == "accepted"
                              ? Colors.green.shade900
                              : shp['status'] == "Rejected"
                              ? Colors.red.shade900
                              : Colors.orange,
                        ),
                      ),
                    ),

                  ),
                        ),
                ],
              );

               }
            ),
         ),
       ],
     ),
    );
  }
}
