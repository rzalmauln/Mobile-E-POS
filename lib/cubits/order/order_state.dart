import 'package:e_pos/data/model/order/order.dart';
import 'package:e_pos/data/model/order_detail/order_detail.dart';
import 'package:e_pos/data/model/product/product.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {}

class InitialOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadingOrderState extends OrderState {
  @override
  List<Object> get props => [];
}

class LoadedOrderState extends OrderState {
  LoadedOrderState(this.orders);
  final List<Order> orders;
  @override
  List<Object> get props => [orders];
}

// class LoadedOrderDetailState extends OrderState {
//   LoadedOrderDetailState(this.ordersDetail);
//   final OrderDetail ordersDetail;
//   @override
//   List<Object> get props => [ordersDetail];
// }

class GetOrderState extends OrderState {
  GetOrderState(this.order);
  final Order order;
  @override
  List<Object> get props => [order];
}

class ErrorOrderState extends OrderState {
  final String errorMessage;
  ErrorOrderState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
