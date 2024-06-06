import 'package:e_pos/data/model/order/order.dart';
import 'package:e_pos/data/model/order_detail/order_detail.dart';
import 'package:e_pos/data/model/product/product.dart';
import 'package:equatable/equatable.dart';

abstract class OrderDetailState extends Equatable {}

class InitialOrderDetailState extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class LoadingOrderDetailState extends OrderDetailState {
  @override
  List<Object> get props => [];
}

class LoadedOrderDetailState extends OrderDetailState {
  LoadedOrderDetailState(this.orderDetails);
  final OrderDetail orderDetails;
  @override
  List<Object> get props => [orderDetails];
}

class ErrorOrderDetailState extends OrderDetailState {
  final String errorMessage;
  ErrorOrderDetailState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
