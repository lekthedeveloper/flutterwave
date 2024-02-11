import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class PaymentService {
  final BuildContext? context;
  final String? email;
  final bool mounted;
  final VoidCallback onPaymentSuccess;
  final String? amount;
  PaymentService(
      {required this.context,
      required this.email,
      required this.mounted,
      required this.amount,
      required this.onPaymentSuccess});

  String _generateRandomString(int length) {
    const String charset =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final Random random = Random();
    List<String> result = List.generate(length, (index) {
      final randomIndex = random.nextInt(charset.length);
      return charset[randomIndex];
    });
    return result.join();
  }

  Future<void> _showLoading(String message) {
    return showDialog(
      context: context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Center(child: Text(message)),
          ),
        );
      },
    );
  }

  handlePaymentInitialization() async {
    try {
      final Customer customer = Customer(email: email!);

      final Flutterwave flutterwave = Flutterwave(
          context: context!,
          publicKey: 'FLWPUBK_TEST-4c53c5d7b8b3bb8bac87c5c1f65739e6-X',
          currency: 'NGN',
          redirectUrl: 'https://facebook.com',
          txRef: _generateRandomString(
              10), //you can create your own function to specify your own txRef
          amount: amount!,
          customer: customer,
          paymentOptions: "card, payattitude, barter, bank transfer, ussd",
          customization: Customization(title: "Tasty Wave"),
          isTestMode: true);
      final ChargeResponse response = await flutterwave.charge();
      if (response.status == 'successful') {
        try {
          onPaymentSuccess();
        } catch (error) {
          debugPrint(error.toString());
        }
      } else if (response.status == 'cancelled') {
        if (mounted) {
          _showLoading('Payment was Cancelled');
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
