import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalshopapp/models/order.dart';
import 'package:finalshopapp/screens/admin_screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: Text('There is no Orders'),);
          } else {
              //List<Order> orders=[];
             return ListView.builder(
               itemCount: snapshot.data.docs.length,
                 itemBuilder: (context,index) {
                   DocumentSnapshot order = snapshot.data.docs[index];
                   Order newOrder = Order(
                       order['totalPrice'],
                       order['address'],
                      order.id,
                   );
                   return Padding(
                       padding: const EdgeInsets.all(20),
                     child: GestureDetector(
                         onTap: () {
                           Navigator.pushNamed(context, OrderDetailsScreen.id,
                               arguments: newOrder.documentId);
                         },
                         child: Container(
                           height: MediaQuery.of(context).size.height * .2,
                           color: kSecondaryColor,
                             child: Padding(
                               padding: const EdgeInsets.all(10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text('Totall Price = \$${newOrder.totalPrice}',
                                       style: TextStyle(
                                           fontSize: 18, fontWeight: FontWeight.bold)),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text(
                                     'Address is ${newOrder.address}',
                                     style: TextStyle(
                                         fontSize: 18, fontWeight: FontWeight.bold),
                                   ),

                                 ],
                               ),
                             )

                         )
                     ),
                   );
                 }
             );
          }
        },
      ),
    );
  }
}
