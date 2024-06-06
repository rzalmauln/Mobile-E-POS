import 'package:bloc/bloc.dart';
import 'package:e_pos/cubits/product/product_state.dart';
import 'package:e_pos/data/model/product/product.dart';
import 'package:e_pos/data/services/product_service.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productService) : super(InitialProductState()) {
    loadProducts();
  }

  final ProductService productService;

  void loadProducts() async {
    emit(LoadingProductState());
    try {
      final products = await productService.getProducts();
      emit(LoadedProductState(products));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void getProduct(int id) async {
    emit(LoadingProductState());
    try {
      Product product = await productService.getProduct(id);
      emit(GetProductState(product));
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  Future<String> getProductName(int id) async {
    emit(LoadingProductState());
    try {
      Product product = await productService.getProduct(id);
      emit(GetProductState(product));
      return product.name;
    } catch (e) {
      emit(ErrorProductState(e.toString()));
      return "";
    }
  }

  void addProduct(String name, int stock, int price) async {
    emit(LoadingProductState());
    try {
      await productService.insertProduct(name, stock, price);
      loadProducts();
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void updateProduct(Product product) async {
    emit(LoadingProductState());
    try {
      await productService.updateProduct(product);
      loadProducts();
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }

  void deleteProduct(int id) async {
    emit(LoadingProductState());
    try {
      await productService.deleteProduct(id);
      loadProducts();
    } catch (e) {
      emit(ErrorProductState(e.toString()));
    }
  }
}
