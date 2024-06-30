import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/cart_service.dart';
import '../widgets/product_item.dart';
import '../screens/product_details_screen.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final String categoryId;

  ProductByCategoryScreen({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products by Category'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productService.getProductsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: products[index],
                onAddToCart: () {
                  final cartService =
                      Provider.of<CartService>(context, listen: false);
                  cartService.addToCart(products[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Added to cart: ${products[index].name}')),
                  );
                },
                onViewDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(product: products[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
