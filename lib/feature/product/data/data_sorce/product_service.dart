import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product_model.dart';

class ProductService {
  final _client = Supabase.instance.client;

  /// add product with image
  Future<String> uploadImage(File file, String fileName) async {
  await _client.storage.from('product-images').upload(fileName, file);
  return _client.storage.from('product-images').getPublicUrl(fileName);
}

Future<void> addProduct(ProductModel product) async {
  return  _client.from('products').insert(product.toMap());
}

/// TODO: Add pagination
/// 0 -> 10    from ->0 to -> 9
/// 1-> 10     from -> 10 to -> 19
/// 2-> 10     from -> 20 to -> 29
  Future<List<Map<String, dynamic>>> fetchProductsPaginated(int page, int limit) async {
  final from = page * limit;
  final to = from + limit - 1;

  final data = await _client
      .from('products')
      .select()
      .range(from, to);

  return data;
}
}
