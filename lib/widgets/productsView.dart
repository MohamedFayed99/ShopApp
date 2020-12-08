import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalshopapp/models/product.dart';
import 'package:finalshopapp/screens/product_information_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  final String productCategory;
  ProductsView(this.productCategory);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').where('productCategory',isEqualTo: widget.productCategory).snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          } else {
            return GridView.builder(
              itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8
                ),
                itemBuilder: (context,index){
                  DocumentSnapshot product = snapshot.data.docs[index];
                  Product newProduct = Product(
                    pId: index.toString(),
                    pName: product['productName'],
                    pImageLocation: product['productImageLocation'],
                    pDescription: product['productDescription'],
                    pCategory: product['productCategory'],
                    pPrice: product['productPrice']
                  );
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(ProductInfoScreen.id,
                          arguments: newProduct
                        );
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                                image: AssetImage(product['productImageLocation']),
                                fit: BoxFit.fill,
                              )
                          ),
                          Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: .6,
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          product['productName'].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '\$ ${product['productPrice'].toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        }
    );
  }
}
