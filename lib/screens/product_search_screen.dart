import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import '../screens/auth/login_screen.dart';
import '../screens/product_details_screen.dart';
import '../models/user.dart';
import '../services/cart_service.dart';

class ProductSearchScreen extends StatelessWidget {
  final String searchQuery;

  ProductSearchScreen({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    // Replace with actual method to search products based on searchQuery
    final List<Product> searchResults =
        []; // Replace with actual search results

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final product = searchResults[index];
          return ProductItem(
            product: product,
            onAddToCart: () {
              final user = Provider.of<User>(context, listen: false);
              if (user.isAuthenticated) {
                final cartService =
                    Provider.of<CartService>(context, listen: false);
                cartService.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to cart: ${product.name}')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }
            },
            onViewDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
