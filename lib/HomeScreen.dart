import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Razorpay? _razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  openCheckout( ) async {

    // print("Check RazorPay_Key_ID >> "+RazorPay_Key_ID.toString());
    var options = {
      'key': "rzp_test_6SCaRfgAu27hKl",
      // 'key': RazorPay_Key_ID.toString(),
      // 'order_id':orderid,
      'timeout':'600',
      'amount': (50 * 100).toString(),
      //given money...
      'name': "Hemant",
      'description': 'Hemant lakhara',
      //those given pay details...
      'prefill': {
        // 'contact': sharedPreferences!.getString("phoneNo"),
        // 'name':'${ sharedPreferences!.getString("first_name")} ${ sharedPreferences!.getString("last_name")}',
        // 'email': ""
      },
      'external': {
        'wallets': ['paytm']
      }

    };
    print("options" + options.toString());
    try {
      _razorpay!.open(options);
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      debugPrint("erroe "+e.toString());
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log("SUCCESS           ${response.toString()}");



    // controller.getSingleAstropackagesPurchaseData(widget.packid,response.paymentId);




    // Fluttertoast.showToast(
    //     msg: "SUCCESS paymentId : " + response.paymentId!, timeInSecForIosWeb: 4);
  }
  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      // isLoading = false;
    });
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     timeInSecForIosWeb: 4);
  }
  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      // isLoading = false;
    });
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razor-Pay',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: (){
                  openCheckout( );
                },
                child:Text('Pay Now',style: TextStyle(color: Colors.white),)
            ),
          ),
        //  Text('kjjjj')
        ],
      ),
    );
  }
}
