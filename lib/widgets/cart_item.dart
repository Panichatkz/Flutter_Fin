import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart'; // Import Product model if not already imported
import '../services/cart_service.dart'; // Ensure CartService is imported correctly

class CartItem extends StatelessWidget {
  final Product product;

  CartItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context, listen: false);

    return ListTile(
      leading: Image.network(product.imageUrl, fit: BoxFit.cover),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.remove_shopping_cart),
        onPressed: () {
          cartService.removeFromCart(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} removed from cart'),
            ),
          );
        },
      ),
    );
  }
}
