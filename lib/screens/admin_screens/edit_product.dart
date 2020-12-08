import 'package:finalshopapp/models/product.dart';
import 'package:finalshopapp/services/firestore_services.dart';
import 'package:finalshopapp/widgets/custom_textField.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  static String id = 'EditProductScreen';
  String name, price, description, category, imagePath;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final firestoreServices = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
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
                initialValue: product.pName,

              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Price',
                onClicked: (value){
                  price = value;
                },
                initialValue: product.pPrice.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Description',
                onClicked: (value){
                  description = value;
                },
                initialValue: product.pDescription,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Category',
                onClicked: (value){
                  category = value;
                },
                initialValue: product.pCategory,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hint: 'Product Image Path',

                onClicked: (value){
                  imagePath = value;
                },
                initialValue: product.pImageLocation,
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:100),
                child: RaisedButton(
                  child: Text('Edit Product'),
                  onPressed: () async {
                    if(globalKey.currentState.validate()){
                      globalKey.currentState.save();
                      firestoreServices.editProduct(product.pId, {
                        'productName': name,
                        'productPrice': price,
                        'productDescription': description,
                        'productCategory': category,
                        'productImageLocation': imagePath,
                      });

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
