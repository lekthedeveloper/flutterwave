import 'package:flutter/material.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

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
      body: const Center(
        child: Text('Your payment is successful'),
      ),
    );
  }
}
