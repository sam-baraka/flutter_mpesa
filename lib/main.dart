import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

void main(){
  MpesaFlutterPlugin.setConsumerKey("Your Consumer Key");
  MpesaFlutterPlugin.setConsumerSecret("Your consumer secret");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var number=TextEditingController();
  //Method to initiate the tansaction
  Future<void> startCheckOut({
  String userPhone, String amount
})async{
    dynamic transactionInitialisation;
    try{
      transactionInitialisation= await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: double.parse(amount),
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri.parse("https://sandbox.safaricom.co.ke/"),
          accountReference: "Flutter Mpesa Tutorial",
          phoneNumber: userPhone,
          transactionDesc: "Purchase",
          baseUri: Uri.parse("https://sandbox.safaricom.co.ke/"),
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      print("Transaction Result:"+ transactionInitialisation.toString());
      return transactionInitialisation;
    }
    catch(e) {
      print("Exception:"+ e.toString());

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: (){
            startCheckOut(userPhone: "254797301429",amount: "1");
          },
          child: Text("Pay Now"),
        ),
      ),
    );
  }
}

