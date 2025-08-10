
import '../../data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final bool hasMore;
  ProductLoaded(this.products, {this.hasMore = true});
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
