import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Click_To_Shop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Products Sold:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...cartService.items.map((product) {
              return Text('${product.name} - \$${product.price}');
            }).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cartService.clearCart();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      ),
    );
  }
}
