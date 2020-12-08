import 'package:finalshopapp/constants.dart';
import 'package:finalshopapp/screens/admin_screens/add_product_screen.dart';
import 'package:finalshopapp/screens/admin_screens/manage_product_screen.dart';
import 'package:finalshopapp/screens/admin_screens/orders_screen.dart';
import 'package:flutter/material.dart';
class AdminScreen extends StatelessWidget {
  static String id = 'AdminScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text('Add product'),
                onPressed: (){
                  Navigator.of(context).pushNamed(AddProductScreen.id);
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                child: Text('Edit product'),
                onPressed: (){
                  Navigator.of(context).pushNamed(ManageProductScreen.id);
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                child: Text('View Orders'),
                onPressed: (){
                  Navigator.of(context).pushNamed(OrdersScreen.id);
                },
              ),
            ],



          ),
        )
    );
  }
}
