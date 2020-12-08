import 'file:///F:/courses/android%20studio%20projects/final_shop_app/lib/screens/admin_screens/admin_home_screen.dart';
import 'package:finalshopapp/provider/cartItem.dart';
import 'package:finalshopapp/screens/admin_screens/add_product_screen.dart';
import 'package:finalshopapp/screens/admin_screens/edit_product.dart';
import 'package:finalshopapp/screens/admin_screens/manage_product_screen.dart';
import 'package:finalshopapp/screens/admin_screens/order_details_screen.dart';
import 'package:finalshopapp/screens/admin_screens/orders_screen.dart';
import 'package:finalshopapp/screens/cart_screen.dart';
import 'package:finalshopapp/screens/home_screen.dart';
import 'package:finalshopapp/screens/product_information_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartItem(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context)=> LoginScreen(),
          SignupScreen.id: (context)=> SignupScreen(),
          HomeScreen.id: (context)=> HomeScreen(),
          AdminScreen.id: (context) => AdminScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          ManageProductScreen.id: (context) => ManageProductScreen(),
          EditProduct.id: (context) => EditProduct(),
          ProductInfoScreen.id: (context) => ProductInfoScreen(),
          CartScreen.id: (context) => CartScreen(),
          OrdersScreen.id: (context) => OrdersScreen(),
          OrderDetailsScreen.id: (context) => OrderDetailsScreen(),

        },
      ),
    );
  }
}
