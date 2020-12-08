import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalshopapp/models/product.dart';
import 'package:finalshopapp/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:finalshopapp/services/firestore_services.dart';

class AddProductScreen extends StatelessWidget {
  static String id = 'AddProductScreen';
  String name, price, description, category, imagePath;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final firestoreServices = FirestoreServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: globalKey,
        child: ListView(
          padding: EdgeInsets.only(top: 150),
          children: [
            SizedBox(width: double.infinity,),
            CustomTextField(
              hint: 'Product Name',
              onClicked: (value){
                name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Price',
              onClicked: (value){
                price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Description',
              onClicked: (value){
                description = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Category',
              onClicked: (value){
                category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Product Path',
              onClicked: (value){
                imagePath = value;
              },
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:100),
              child: RaisedButton(
                child: Text('Add Product'),
                onPressed: () async {
                  if(globalKey.currentState.validate()){
                    globalKey.currentState.save();
                    await firestoreServices.addProduct(Product(
                      pName: name,
                      pPrice: price,
                      pDescription: description,
                      pCategory: category,
                      pImageLocation: imagePath,
                    ));
                  }

                },
              ),
            )
          ],
        ),
      )
      
    );
  }
}
