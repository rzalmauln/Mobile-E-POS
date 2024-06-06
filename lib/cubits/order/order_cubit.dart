import 'package:bloc/bloc.dart';
import 'package:e_pos/cubits/cart/cart_item.dart';
import 'package:e_pos/cubits/order/order_state.dart';
import 'package:e_pos/cubits/order/order_state.dart';
import 'package:e_pos/data/model/order/order.dart';
import 'package:e_pos/data/model/order/order.dart';
import 'package:e_pos/data/model/order_detail/order_detail.dart';
import 'package:e_pos/data/services/order_detail_service.dart';
import 'package:e_pos/data/services/order_service.dart';
import 'package:e_pos/data/services/order_service.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderService, this.orderDetailService)
      : super(InitialOrderState()) {
    loadOrders();
  }

  final OrderService orderService;
  final OrderDetailService orderDetailService;

  void loadOrders() async {
    emit(LoadingOrderState());
    try {
      final orders = await orderService.getOrders();
      emit(LoadedOrderState(orders));
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  void getOrder(int id) async {
    emit(LoadingOrderState());
    try {
      Order order = await orderService.getOrder(id);
      emit(GetOrderState(order));
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  Future<int> getLastIdOrder() async {
    emit(LoadingOrderState());
    try {
      final idOrder = await orderService.getLastIdOrder();
      return idOrder;
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
      return 0;
    }
  }

  void addOrder(int storeId, int total, DateTime orderDate) async {
    emit(LoadingOrderState());
    try {
      await orderService.insertOrder(storeId, total, orderDate);
      loadOrders();
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  void addOrderDetail(int orderId, List<CartItem> items) async {
    emit(LoadingOrderState());
    try {
      for (int i = 0; i < items.length; i++) {
        await orderDetailService.insertOrderDetail(orderId, items[i].product.id,
            items[i].quantity, (items[i].quantity * items[i].product.price));
      }
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  void updateOrder(Order order) async {
    emit(LoadingOrderState());
    try {
      await orderService.updateOrder(order);
      loadOrders();
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }

  void deleteOrder(int id) async {
    emit(LoadingOrderState());
    try {
      await orderService.deleteOrder(id);
      loadOrders();
    } catch (e) {
      emit(ErrorOrderState(e.toString()));
    }
  }
}
