import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalshopapp/models/product.dart';
import 'package:finalshopapp/screens/admin_screens/edit_product.dart';
import 'package:finalshopapp/services/firestore_services.dart';
import 'package:finalshopapp/widgets/custom_popup_menu.dart';
import 'package:flutter/material.dart';

class ManageProductScreen extends StatefulWidget {
  static String id = 'ManageProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<ManageProductScreen> {
  final firestoreServices = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context , snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var documentData = doc.data();
            products.add(Product(
                pName: documentData['productName'],
                pPrice: documentData['productPrice'],
                pCategory: documentData['productCategory'],
                pDescription: documentData['productDescription'],
                pImageLocation: documentData['productImageLocation'],
                pId: doc.id,
            ));
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
              itemBuilder: (context,index){
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: GestureDetector(
                    onTapUp: (details){
                      double dx= details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.width - dy;
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(
                                child: Text('Edit'),
                                onClick: (){
                                  Navigator.of(context).popAndPushNamed(EditProduct.id,
                                      arguments: products[index],
                                  );
                                }
                            ),
                            MyPopupMenuItem(
                                child: Text('Delete'),
                                onClick: (){
                                  firestoreServices.deleteProduct(products[index].pId);
                                  Navigator.pop(context);
                                }
                            ),
                          ]
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Image(
                              image: AssetImage(products[index].pImageLocation),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice}',
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
              },
            itemCount: products.length,

          );
        }
      ),
    );
  }


}
