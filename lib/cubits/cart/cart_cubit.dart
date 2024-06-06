import 'package:bloc/bloc.dart';
import 'package:e_pos/cubits/cart/cart_item.dart';
import 'package:e_pos/cubits/cart/cart_state.dart';
import 'package:e_pos/data/model/product/product.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: [], pay: 0));

  List<CartItem> getAllCart() {
    return state.items;
  }

  void increaseItemQuantity(int productId) {
    int last_pay = state.pay;
    final updatedItems = state.items.map((item) {
      if (item.product.id == productId) {
        if (item.quantity < item.product.stock) {
          return item.copyWith(quantity: item.quantity + 1);
        }
      }
      return item;
    }).toList();
    emit(CartState(items: updatedItems, pay: last_pay));
  }

  void decreaseItemQuantity(int productId) {
    int last_pay = state.pay;

    final updatedItems = state.items.map((item) {
      if (item.product.id == productId && item.quantity > 0) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(CartState(items: updatedItems, pay: last_pay));
  }

  // void updateItemQuantity(int productId, int quantity) {
  //   final updatedItems = state.items.map((item) {
  //     if (item.product.id == productId) {
  //       return item.copyWith(quantity: quantity);
  //     }
  //     return item;
  //   }).toList();
  //   emit(CartState(items: updatedItems));
  // }

  void setCartFromProducts(List<Product> products) {
    int last_pay = state.pay;

    final items = products
        .map((product) => CartItem(product: product, quantity: 0))
        .toList();
    emit(CartState(items: items, pay: last_pay));
  }

  void clearCart() {
    emit(CartState(items: [], pay: 0));
  }

  int getAllQuantity() {
    int allQuantity = 0;
    for (int i = 0; i < state.items.length; i++) {
      allQuantity += state.items[i].quantity;
    }
    return allQuantity;
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < state.items.length; i++) {
      totalPrice += state.items[i].quantity * state.items[i].product.price;
    }
    return totalPrice;
  }

  void setPay(int payment) {
    state.pay = payment;
  }

  int getPay() {
    return state.pay;
  }

  int getChange() {
    return getTotalPrice() - getPay();
  }
}
