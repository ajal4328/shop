import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ViewEquipments extends StatefulWidget {
  @override
  _ViewEquipmentsState createState() => _ViewEquipmentsState();
}

class _ViewEquipmentsState extends State<ViewEquipments> {
  List products = [];
  bool isLoading = true;
  String baseUrl = "";


  late Razorpay _razorpay;

  var _selectedProductForBuy;

  @override
  void initState() {
    super.initState();
    getData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _startRazorpay(var p) {
    _selectedProductForBuy = p;
    double price = double.parse(p['d_price'].toString());
    var options = {
      'key': 'rzp_test_MJOAVy77oMVaYv',
      'amount': (price * 100).toInt(),
      'name': 'Agri Equipment Sale',
      'description': 'Purchase: ${p['name']}',
      'prefill': {'contact': '9876543210', 'email': 'farmer@example.com'},
      'theme': {'color': '#FF9800'}
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) => _handleBuy(_selectedProductForBuy);

  void _handlePaymentError(PaymentFailureResponse response) => _showMsg("Payment Failed", isError: true);

  Future<void> getData() async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    baseUrl = pr.getString('url') ?? "";
    try {
      var res = await http.get(Uri.parse("$baseUrl/ViewEquipmentsAPI/"));
      var data = jsonDecode(res.body)['products'];
      for (var item in data) {
        item['rent_price'] = (double.parse(item['d_price'].toString()) / 10);
      }
      setState(() { products = data; isLoading = false; });
    } catch (e) { setState(() => isLoading = false); }
  }

  Future<void> _handleBuy(var p) async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    var res = await http.post(Uri.parse("$baseUrl/ProcessBuyEquipment/"), body: {
      'lid': pr.getString('lid'), 'pid': p['id'].toString(), 'price': p['d_price'].toString(),
    });
    if (jsonDecode(res.body)['status'] == 'ok') {
      _showMsg("Equipment Purchased!");
      getData();
    }
  }

  void _showMsg(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg), backgroundColor: isError ? Colors.red : Colors.green[800], behavior: SnackBarBehavior.floating,
    ));
  }


  Widget _dateTile(String label, DateTime date, VoidCallback onTap) => ListTile(
    tileColor: Colors.grey[100], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Text("$label: ${DateFormat('yyyy-MM-dd').format(date)}"), trailing: const Icon(Icons.calendar_today), onTap: onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text("FARM EQUIPMENTS"), centerTitle: true, elevation: 0, backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, i) {
          var p = products[i];
          bool isForRent = p['type'].toString().toLowerCase() == 'rent';
          bool isForSale = p['type'].toString().toLowerCase() == 'sale';

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(p['image'], height: 200, width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("Dealer: ${p['dealer']}", style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          if (isForSale) Text("₹${p['d_price']}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                          if (isForRent) Text("₹${p['rent_price'].toStringAsFixed(1)} / day", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: isForRent ? Colors.green[50] : Colors.blueGrey[50], borderRadius: BorderRadius.circular(8)),
                            child: Text(p['type'].toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isForRent ? Colors.green : Colors.blueGrey)),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),

                      if (isForSale)
                        SizedBox(width: double.infinity, child: ElevatedButton.icon(
                          onPressed: p['stock'] > 0 ? () => _startRazorpay(p) : null,
                          icon: const Icon(Icons.shopping_cart),
                          label: Text(p['stock'] > 0 ? "BUY NOW" : "OUT OF STOCK"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[900], foregroundColor: Colors.white),
                        )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}