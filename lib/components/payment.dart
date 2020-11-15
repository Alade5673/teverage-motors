// import 'package:flutter/material.dart';
// import 'package:rave_flutter/rave_flutter.dart';
// // import 'package:flutter_rave/flutter_rave.dart';
// import 'package:intl/intl.dart';

// void main() => runApp(Payment());

// class Payment extends StatelessWidget {
// // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       color: Colors.green,
//       theme: ThemeData(primaryColor: Colors.green),
//       title: 'Flutterwave',
//       debugShowCheckedModeBanner: false,
//       home: PaymentPage(title: 'Flutterwave'),
//     );
//   }
// }

// class PaymentPage extends StatefulWidget {
//   PaymentPage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Builder(
//           builder: (context) => SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10),
//               child: InkWell(
//                 onTap: () => _pay(context),
//                 child: Card(
//                   color: Colors.green,
//                   elevation: 15,
//                   child: Container(
//                     height: 250,
//                     width: MediaQuery.of(context).size.width,
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             "Card Payment",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Icon(
//                             Icons.payment,
//                             color: Colors.black,
//                             size: 30,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// //   _pay(BuildContext context) {
// //     final snackBar_onFailure = SnackBar(content: Text('Transaction failed'));
// //     final snackBar_onClosed = SnackBar(content: Text('Transaction closed'));
// //     final _rave = RaveCardPayment(
// //       isDemo: true,
// //       encKey: "a3b95dd95f7b447edcf9a4a4",
// //       publicKey: "FLWPUBK-4026efed0cbdd6516e8714bbbbadd7e9-X",
// //       transactionRef: "hvHPvKYaRuJLlJWSPWGGKUyaAfWeZKnm",
// //       amount: 100,
// //       email: "alade5673@gmail.com",
// //       onSuccess: (response) {
// //         print("$response");
// //         print("Transaction Successful");
// //         if (mounted) {
// //           Scaffold.of(context).showSnackBar(
// //             SnackBar(
// //               content: Text("Transaction Sucessful!"),
// //               backgroundColor: Colors.green,
// //               duration: Duration(
// //                 seconds: 5,
// //               ),
// //             ),
// //           );
// //         }
// //       },
// //       onFailure: (err) {
// //         print("$err");
// //         print("Transaction failed");
// //         Scaffold.of(context).showSnackBar(snackBar_onFailure);
// //       },
// //       onClosed: () {
// //         print("Transaction closed");
// //         Scaffold.of(context).showSnackBar(snackBar_onClosed);
// //       },
// //       context: context,
// //     );
// //     _rave.process();
// //   }
// // }


// processTransaction() async {
//     // Get a reference to RavePayInitializer
//     var initializer = RavePayInitializer(
//         amount: 500, publicKey: publicKey, encryptionKey: encryptionKey)
//       ..country = "NG"
//       ..currency = "NGN"
//       ..email = "customer@email.com"
//       ..fName = "Ciroma"
//       ..lName = "Adekunle"
//       ..narration = narration ?? ''
//       ..txRef = txRef
//       ..subAccounts = subAccounts
//       ..acceptMpesaPayments = acceptMpesaPayment
//       ..acceptAccountPayments = acceptAccountPayment
//       ..acceptCardPayments = acceptCardPayment
//       ..acceptAchPayments = acceptAchPayments
//       ..acceptGHMobileMoneyPayments = acceptGhMMPayments
//       ..acceptUgMobileMoneyPayments = acceptUgMMPayments
//       ..staging = true
//       ..isPreAuth = preAuthCharge
//       ..displayFee = shouldDisplayFee;

//     // Initialize and get the transaction result
//     RaveResult response = await RavePayManager()
//         .prompt(context: context, initializer: initializer);
//   }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_rave/flutter_rave.dart';

// // class _MyHomePageState extends State<MyHomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: Builder(
// //         builder: (context) => SingleChildScrollView(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: <Widget>[
// //                   Text(
// //                     'Pay Me',
// //                   ),
// //                   FlatButton.icon(
// //                     onPressed: () {
// //                       _pay(context);
// //                     },
// //                     icon: Icon(Icons.email),
// //                     label: Text("Pay"),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //       ),
// //     );
// //   }

// //   _pay(BuildContext context) {
// //     final _rave = RaveCardPayment(
// //       isDemo: true,
// //       encKey: "c53e399709de57d42e2e36ca",
// //       publicKey: "FLWPUBK-d97d92534644f21f8c50802f0ff44e02-X",
// //       transactionRef: "SCH${DateTime.now().millisecondsSinceEpoch}",
// //       amount: 100,
// //       email: "demo1@example.com",
// //       onSuccess: (response) {
// //         print("$response");
// //         print("Transaction Successful");

// //         if (mounted) {
// //           Scaffold.of(context).showSnackBar(
// //             SnackBar(
// //               content: Text("Transaction Sucessful!"),
// //               backgroundColor: Colors.green,
// //               duration: Duration(
// //                 seconds: 5,
// //               ),
// //             ),
// //           );
// //         }
// //       },
// //       onFailure: (err) {
// //         print("$err");
// //         print("Transaction failed");
// //       },
// //       onClosed: () {
// //         print("Transaction closed");
// //       },
// //       context: context,
// //     );

// //     _rave.process();
// //   }
// // }