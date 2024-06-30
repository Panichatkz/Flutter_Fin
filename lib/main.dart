import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/cart_service.dart';
import 'services/product_service.dart';
import 'services/firebase_config.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';

import 'screens/product_search_screen.dart';
import 'screens/paymentScreen.dart';
import 'screens/receiptScreen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initializeFirebase(); // Ensure Firebase is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<ProductService>(create: (_) => ProductService()),
        ChangeNotifierProvider<CartService>(create: (_) => CartService()),
      ],
      child: MaterialApp(
        title: 'Click_To_Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthService>(
          builder: (context, authService, _) {
            final user = authService.currentUser;
            if (user != null) {
              return HomeScreen();
            } else {
              return AuthScreen(); // Redirect to AuthScreen if not authenticated
            }
          },
        ),
        routes: {
          '/auth': (context) => AuthScreen(), 
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
          '/search': (context) => ProductSearchScreen(searchQuery: ''),
          '/payment': (context) => PaymentScreen(),
          '/receipt': (context) => ReceiptScreen(),
        },
      ),
    );
  }
}
