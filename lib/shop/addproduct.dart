import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;

class addproduct extends StatefulWidget {
  const addproduct({super.key});

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {

  String? selectcategory;
  TextEditingController Pname=TextEditingController();

  TextEditingController Pdetail=TextEditingController();
  TextEditingController Pcategory=TextEditingController();
  TextEditingController Pmrp=TextEditingController();
  TextEditingController Pdiscount=TextEditingController();
  final _addp=GlobalKey<FormState>();

  File?_image;
  String?_Uploadurl;
  ImageSource adding=ImageSource.gallery;
  final ImagePicker picker=ImagePicker();

  Future<void>addimage()async{
    final pickfile=await picker.pickImage(source: adding);

    if(pickfile!= null){

      setState(() {
        _image=File(pickfile.path);
      });
    }
  }

  final FirebaseFirestore _product=FirebaseFirestore.instance;

  newproduct()async{
    if(!_addp.currentState!.validate())return;

    try{

      final cloudName = 'dci8lztpv' ;
      final uploadPreset = 'shopitem' ;

      final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      final request= http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file',_image!.path));

      final response = await request.send();
      final resBody= await response.stream.bytesToString();
      final data= jsonDecode(resBody);
      setState(() {
        _Uploadurl=data['secure_url'];
      });

      String usr=FirebaseAuth.instance.currentUser!.uid;

      await _product.collection('product').add({

        'name':Pname.text,
        'uid':usr,

        'details':Pdetail.text,
        'mrp':Pmrp.text,
        'discount':Pdiscount.text,
        'category':Pcategory.text,
        'uri':_Uploadurl,
        'CreatedAt': FieldValue.serverTimestamp(),

      });

      ScaffoldMessenger.of(context)..showSnackBar(
        SnackBar(content: Text('Success'))
      );
      setState(() {
        _image=null;
        selectcategory=null;
        _Uploadurl=null;
      });
      Pname.clear();
      Pdetail.clear();
      Pcategory.clear();
      Pmrp.clear();
      Pdiscount.clear();



    }
    catch(e){}



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                'Add Product',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.blueGrey.shade800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 25),


              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(3, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _addp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: addimage,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.blueGrey.shade100,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _image == null
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate_rounded,
                                  size: 45, color: Colors.grey.shade600),
                              const SizedBox(height: 8),
                              Text(
                                "Add Image",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              _image!,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),


                      TextFormField(
                        controller: Pname,
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                          prefixIcon:
                          const Icon(Icons.shopping_bag_outlined, color: Colors.blue),
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            BorderSide(color: Colors.blueGrey.shade200, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.blue, width: 1.8),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter Product Name' : null,
                      ),
                      const SizedBox(height: 18),





                      TextFormField(
                        controller: Pdetail,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Product Details',
                          prefixIcon:
                          const Icon(Icons.description_outlined, color: Colors.orange),
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            BorderSide(color: Colors.blueGrey.shade200, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.orange, width: 1.8),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter Product Details' : null,
                      ),
                      const SizedBox(height: 25),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Pmrp,
                        decoration: InputDecoration(
                          labelText: 'MRP Price',
                          prefixIcon:
                          const Icon(Icons.currency_rupee, color: Colors.green),
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            BorderSide(color: Colors.blueGrey.shade200, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.green, width: 1.8),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter Product Price' : null,
                      ),
                      const SizedBox(height: 18),

                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: Pdiscount,
                        decoration: InputDecoration(
                          labelText: 'Product Discount',
                          prefixIcon:
                          const Icon(Icons.percent_outlined, color: Colors.black),
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            BorderSide(color: Colors.blueGrey.shade200, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Colors.green, width: 1.8),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Enter Product Discount' : null,
                      ),
                      const SizedBox(height: 18),

                     DropdownButtonFormField<String>(
                       value: selectcategory,

                         decoration: InputDecoration(
                           labelText: 'Select Category',
                           prefixIcon: Icon(Icons.category,color: Colors.blue,),
                           filled: true,
                           fillColor: Colors.blueGrey.shade50,
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                             borderSide: BorderSide(color: Colors.blueGrey.shade50,width: 1)
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(15),
                             borderSide: BorderSide(color: Colors.blueGrey.shade50,width: 1)
                           )
                         ),

                         items: [

                           'fashion',
                           'beauty',
                           'grocery',
                           'gadgets',
                           'appliances',
                           'electronic',
                           'toys',
                           'mobiles',
                           'sports'

                         ].map((category){
                           return DropdownMenuItem(
                               value: category,
                               child: Text(category));
                         }).toList(),

                         onChanged: (value){
                         setState(() {
                           selectcategory=value;
                           Pcategory.text=value!;
                         });
                         },
                         validator: (value)=> value == null? 'Please select your category':null,
                         ),
                       SizedBox(height: 18),


                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: newproduct,
                          icon: const Icon(Icons.cloud_upload_rounded, color: Colors.white),
                          label: const Text(
                            'Upload Product',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
