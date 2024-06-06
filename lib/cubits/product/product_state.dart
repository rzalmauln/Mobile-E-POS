import 'package:e_pos/data/model/product/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {}

class InitialProductState extends ProductState {
  @override
  List<Object> get props => [];
}

class LoadingProductState extends ProductState {
  @override
  List<Object> get props => [];
}

class LoadedProductState extends ProductState {
  LoadedProductState(this.products);
  final List<Product> products;
  @override
  List<Object> get props => [products];
}

class GetProductState extends ProductState {
  GetProductState(this.product);
  final Product product;
  @override
  List<Object> get props => [product];
}

class ErrorProductState extends ProductState {
  final String errorMessage;
  ErrorProductState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
