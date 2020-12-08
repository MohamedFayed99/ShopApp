import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalshopapp/models/product.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class OrderDetailsScreen extends StatelessWidget {
  static String id = 'OrderDetailsScreen';
  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').doc(docId).collection('OrderDetails').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index) {
                      DocumentSnapshot product = snapshot.data.docs[index];
                      Product orderedProduct = Product(
                          pName: product['productName'],
                          pQuantity: product['productQuantity'],
                          pPrice: product['productPrice'],
                          pCategory: product['productCategory'],
                      );
                      return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                              height: MediaQuery.of(context).size.height * .2,
                              color: kSecondaryColor,
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('product name : ${orderedProduct.pName}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Quantity : ${orderedProduct.pQuantity}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'product Category : ${orderedProduct.pCategory}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                              )
                          )
                      );
                    }
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text('Confirm Orders'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text('Delete Orders'),
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            );

          }
        },
      ),
    );
  }
}
