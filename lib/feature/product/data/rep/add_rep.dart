import 'package:dartz/dartz.dart';

import '../data_sorce/product_service.dart';
import '../models/product_model.dart';

class AddRep {
  ProductService productService = ProductService();

  Future<Either<String, void>> addProduct(ProductModel product) async {
    try {
      final resualt = await productService.addProduct(product);
      return right(resualt);
    } catch (e) {
      return left(e.toString());
    }
  }
  Future<Either<String,List<ProductModel>>> fetchProductsPaginated(int page, int limit) async {
    try {
      final data = await productService.fetchProductsPaginated(page, limit);
      final resualt=(data as List).map((e) => ProductModel.fromMap(e)).toList();
      if(resualt.isEmpty){
        return left('no data');
        }
        if(resualt.isNotEmpty)
        {
          return right(resualt);
        }
      return right(resualt);
    } catch (e) {
      return left(e.toString());
    }

  }
  
}
