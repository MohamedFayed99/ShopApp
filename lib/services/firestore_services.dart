import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalshopapp/models/product.dart';

class FirestoreServices{

  addProduct(Product product) async{

    final result = await FirebaseFirestore.instance.collection('products')
        .add({
      'productName' : product.pName,
      'productPrice' : product.pPrice,
      'productDescription' : product.pDescription,
      'productCategory': product.pCategory,
      'productImageLocation': product.pImageLocation,
    });

    print(result.id);
  }

  deleteProduct(documentId){
    FirebaseFirestore.instance.collection('products').doc(documentId).delete();
  }

  editProduct(documentId,data){
    FirebaseFirestore.instance.collection('products').doc(documentId).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = FirebaseFirestore.instance.collection('Orders').doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection('OrderDetails').doc().set({
        'productName': product.pName,
        'productPrice': product.pPrice,
        'productQuantity': product.pQuantity,
        'productImageLocation': product.pImageLocation,
        'productCategory': product.pCategory
      });
    }
  }

//  Future<List<Product>> getAllProducts() async{
//    List<Product> loadedProducts=[];
//    await for(var snapshot in FirebaseFirestore.instance.collection('products').snapshots()) {
//      for (var doc in snapshot.docs) {
//        var documentData = doc.data();
//        loadedProducts.add(Product(
//            pName: documentData['productName'],
//            pPrice: documentData['productPrice'],
//            pCategory: documentData['productCategory'],
//            pDescription: documentData['productDescription'],
//            pImageLocation: documentData['productImageLocation']
//        ));
//      }
//    }
//
//    return loadedProducts;
//  }

}