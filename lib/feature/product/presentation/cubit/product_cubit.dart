import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_up/feature/product/data/rep/add_rep.dart';

import '../../data/data_sorce/product_firebase.dart';
import '../../data/data_sorce/product_service.dart';
import '../../data/models/product_model.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService service;
  final AddRep addRep = AddRep();
  final ProductFirebase productFirebase = ProductFirebase();
  final int _limit = 10;
  int _page = 0;
  bool _hasMore = true;
  List<ProductModel> _allProducts = [];

  ProductCubit(this.service) : super(ProductInitial());
///53 
/// 10 10 10 10 10 3 0 0
  Future<void> fetchInitialProducts() async {
    _page = 0;
    _hasMore = true;
    emit(ProductLoading());
      final items = await addRep.fetchProductsPaginated(_page, _limit);
      items.fold((l) => emit(ProductError(l)), (r) {
        _allProducts = r;
        _hasMore = r.length == _limit;
        emit(ProductLoaded(_allProducts, hasMore: _hasMore));
      });
  }

 Future<void> fetchData() async {
    emit(ProductLoading());
    try {
      final items = await productFirebase.getProducts(page:  _page,limit:  _limit,product: _allProducts.last);
      items.fold((l) => emit(ProductError(l)), (r) {
        _allProducts = r;
        _hasMore = r.length == _limit;
        emit(ProductLoaded(_allProducts, hasMore: _hasMore));
      });
    } catch (e) {
      emit(ProductError(e.toString()));
    }
   
 }
  Future<void> fetchMoreProducts() async {
    if (!_hasMore || state is ProductLoading) return;
    _page++;
    emit(ProductLoading());
    try {
      final items = await service.fetchProductsPaginated(_page, _limit);
      _hasMore = items.length == _limit;
      //_allProducts.addAll(items);
      emit(ProductLoaded(_allProducts, hasMore: _hasMore));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> addProductWithImage(
      ProductModel product, File? imageFile) async {
    emit(ProductLoading());
    try {
      String? imageUrl;
      if (imageFile != null) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        imageUrl = await service.uploadImage(imageFile, fileName);
      }

      final updatedProduct = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        createdAt: product.createdAt,
        imageUrl: imageUrl,
      );

      await addRep.addProduct(updatedProduct);
      fetchInitialProducts();
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
