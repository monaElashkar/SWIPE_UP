import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:swipe_up/feature/product/data/models/product_model.dart';

class ProductFirebase {
  getProducts({required int page, ProductModel? product,required int limit}) async {

      //     var querySnapshot = await FirebaseFirestore.instance.collection('products').limit(limit).get();

      // // التحقق من الوصول إلى نهاية المجموعة
      // bool hasReachedEnd = querySnapshot.docs.length < limit;

      // return {
      //   "data": querySnapshot.docs
      //       .map((doc) => doc.data() as Map<String, dynamic>)
      //       .toList(),
      //   "hasReachedEnd": hasReachedEnd
      // };

    var querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy("createdAt", descending: true)
          .limit(10)
          .startAt([product!.createdAt]).get();
    if (page == 0) {
      final data = await FirebaseFirestore.instance
          .collection('products')
          .limit(limit)
          .get();
      return data;

    } else {
      final data = await FirebaseFirestore.instance
          .collection('products')
          .startAfterDocument(product!.toMap() as DocumentSnapshot<Object?>)
          .limit(limit)
          .get();
      return data;
    }
  }


  addProduct(ProductModel product) async {
    await FirebaseFirestore.instance.collection('products').add(product.toMap());
  }
  uploudImage(File file, String fileName) async {
     final uploadTask = await FirebaseStorage.instance.ref('$fileName').putFile(file);
     return uploadTask.ref.getDownloadURL();
       
  }

}


