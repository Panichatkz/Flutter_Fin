// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as CustomUser;
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/product_service.dart';
import '../widgets/product_item.dart';
import '../screens/product_details_screen.dart';
import '../screens/product_search_screen.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context);
    final CustomUser.User? user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(user != null ? 'Products - ${user.email}' : 'Products'),
        actions: user != null
            ? [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              ]
            : [],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          _buildAuthButtons(context, user, authService),
          SizedBox(height: 20),
          _buildSearchField(context),
          SizedBox(height: 20),
          Expanded(
            child: _buildProductList(context, productService, user),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Register'),
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButtons(
      BuildContext context, CustomUser.User? user, AuthService authService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            if (user != null) {
              await authService.signOut(context);
            } else {
              Navigator.pushNamed(context, '/register');
            }
          },
          child: Text(user != null ? 'Logout' : 'Register'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () async {
            if (user != null) {
              await authService.signOut(context);
            } else {
              Navigator.pushNamed(context, '/login');
            }
          },
          child: Text(user != null ? 'Logout' : 'Login'),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search by product name...',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              String query = searchController.text.trim();
              if (query.isNotEmpty) {
                _searchProductsByName(context, query);
              }
            },
          ),
        ),
      ),
    );
  }

  void _searchProductsByName(BuildContext context, String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductSearchScreen(searchQuery: query),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, ProductService productService,
      CustomUser.User? user) {
    return StreamBuilder<List<Product>>(
      stream: productService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Snapshot connection state: ConnectionState.waiting');
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No products available');
          return Center(child: Text('No products available'));
        }
        final products = snapshot.data!;
        print('Products fetched: ${products.length}');
        for (var product in products) {
          print('Product: ${product.name}, Image URL: ${product.imageUrl}');
        }
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
                      content: Text('Added to cart: ${products[index].name}')),
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
    );
  }
}
