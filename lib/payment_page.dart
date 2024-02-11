import 'package:flutter/material.dart';
import 'package:flutterwave_checkout/flutterwave.dart';
import 'package:flutterwave_checkout/payment_success.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'FlutterWave Checkout',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PaymentService(
              amount: '1000',
              context: context,
              email: 'olamilekan@gmail.com',
              mounted: mounted,
              onPaymentSuccess: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PaymentSuccess()));
              },
            ).handlePaymentInitialization();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, minimumSize: const Size(200, 50)),
          child: const Text(
            'Pay now',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
