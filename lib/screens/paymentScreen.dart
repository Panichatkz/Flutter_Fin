import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showPaymentSuccess(context);
              },
              child: Text('Pay with Mpesa'),
            ),
            ElevatedButton(
              onPressed: () {
                _showPaymentSuccess(context);
              },
              child: Text('Pay with Credit Card'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Success'),
          content: Text('Your payment was successful!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/receipt');
              },
            ),
          ],
        );
      },
    );
  }
}
