import 'package:e_pos/cubits/cart/cart_item.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  int pay;

  CartState({required this.items, required this.pay});

  @override
  List<Object> get props => [items];

  get product => null;
}
