import 'package:bloc/bloc.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_state.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_state.dart';
import 'package:e_pos/data/model/order_detail/order_detail.dart';
import 'package:e_pos/data/services/order_detail_service.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this.orderDetailService) : super(InitialOrderDetailState());

  final OrderDetailService orderDetailService;

  void getOrderDetail(int id) async {
    emit(LoadingOrderDetailState());
    try {
      OrderDetail orderDetail = await orderDetailService.getOrderDetail(id);
      emit(LoadedOrderDetailState(orderDetail));
    } catch (e) {
      emit(ErrorOrderDetailState(e.toString()));
    }
  }

  void addOrderDetail(int orderId, int productId, int qty, int price) async {
    emit(LoadingOrderDetailState());
    try {
      await orderDetailService.insertOrderDetail(
          orderId, productId, qty, price);
    } catch (e) {
      emit(ErrorOrderDetailState(e.toString()));
    }
  }

  void updateOrderDetail(OrderDetail orderDetail) async {
    emit(LoadingOrderDetailState());
    try {
      await orderDetailService.updateOrderDetail(orderDetail);
    } catch (e) {
      emit(ErrorOrderDetailState(e.toString()));
    }
  }

  void deleteOrderDetail(int id) async {
    emit(LoadingOrderDetailState());
    try {
      await orderDetailService.deleteOrderDetail(id);
    } catch (e) {
      emit(ErrorOrderDetailState(e.toString()));
    }
  }
}
