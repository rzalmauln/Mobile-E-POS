import 'dart:async';

import 'package:e_pos/cubits/cart/cart_cubit.dart';
import 'package:e_pos/cubits/cart/cart_item.dart';
import 'package:e_pos/cubits/cart/cart_state.dart';
import 'package:e_pos/cubits/order/order_cubit.dart';
import 'package:e_pos/cubits/order/order_state.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_cubit.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_state.dart';
import 'package:e_pos/cubits/product/product_cubit.dart';
import 'package:e_pos/data/model/order/order.dart';
import 'package:e_pos/data/model/order_detail/order_detail.dart';
import 'package:e_pos/data/model/product/product.dart';
import 'package:e_pos/views/keranjang/increment_decrement.dart';
import 'package:e_pos/views/keranjang/widgets/custom_field.dart';
import 'package:e_pos/views/transaksi/detail_transaksi_screen.dart';
import 'package:e_pos/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // print(context.read<CartCubit>().getChange());
      context.read<CartCubit>().setPay(int.parse(_controller.text));
      print(context.read<CartCubit>().getPay());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang',
            style: TextStyle(
                fontSize: 16,
                letterSpacing: -0.32,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.white),
          onTap: () {
            Navigator.pop(context);
            context.read<ProductCubit>().loadProducts();
          },
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline_rounded, color: Colors.white),
            onPressed: () {
              _setAlertDelete(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.bookmark, color: Colors.blue[600]),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'Rincian Transaksi',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tanggal Transaksi",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}/',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ))
                    ],
                  ),
                ),
              ]),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    var item = state.items[index];
                    var id = index + item.product.id;
                    if (item.quantity > 0) {
                      return _buildCard(
                          item.product.id,
                          item.product.name.toString(),
                          item.quantity as int,
                          item.product.price as int,
                          index);
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 39),
            color: Colors.blue[600],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bayar (Check Out)",
                  style: TextStyle(
                      fontSize: 17,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return Text(
                          "Rp. ${context.read<CartCubit>().getTotalPrice().toString()}",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        );
                      },
                    ),
                    BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            context.read<OrderCubit>().addOrder(
                                prefs.getInt('idStore')!,
                                context.read<CartCubit>().getTotalPrice(),
                                DateTime.now());

                            final int idOrder = await context
                                .read<OrderCubit>()
                                .getLastIdOrder();

                            context.read<OrderCubit>().addOrderDetail(idOrder,
                                context.read<CartCubit>().getAllCart());

                            for (int i = 0;
                                i <
                                    context
                                        .read<CartCubit>()
                                        .getAllCart()
                                        .length;
                                i++) {
                              context.read<ProductCubit>().updateProduct(
                                  Product(
                                      id: context
                                          .read<CartCubit>()
                                          .getAllCart()[i]
                                          .product
                                          .id,
                                      name: context
                                          .read<CartCubit>()
                                          .getAllCart()[i]
                                          .product
                                          .name,
                                      stock: context
                                              .read<CartCubit>()
                                              .getAllCart()[i]
                                              .product
                                              .stock -
                                          context
                                              .read<CartCubit>()
                                              .getAllCart()[i]
                                              .quantity,
                                      price: context
                                          .read<CartCubit>()
                                          .getAllCart()[i]
                                          .product
                                          .price));
                            }

                            if (idOrder != 0) {
                              _setAlert(context, idOrder);
                            }
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: Colors.white,
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      int productId, String title, int qty, int price, int index) {
    // var item = stock[index];
    TextEditingController qtyController =
        TextEditingController(text: qty.toString());

    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${qty} x ${price}",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final cartItem = state.items.firstWhere(
                        (item) => item.product.id == productId,
                        orElse: () => CartItem(
                            product: state.items[index].product, quantity: 0),
                      );

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (cartItem.quantity > 0) {
                                context
                                    .read<CartCubit>()
                                    .decreaseItemQuantity(productId);
                              }
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              cartItem.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CartCubit>()
                                  .increaseItemQuantity(productId);
                              print(context.read<CartCubit>().getAllCart());
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Colors.blue[600],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Text(
                "Rp${(qty * price).toString()}",
                style: TextStyle(fontSize: 11, color: Colors.blue[600]),
              ),
            ],
          ),
        ));
  }

  void _setAlert(BuildContext context, int idOrder) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        title: Center(
          child: Text(
            'Transaksi Berhasil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.green[600],
            ),
          ),
        ),
        content: Icon(
          Icons.check_box_rounded,
          color: Colors.green[600],
          size: 32,
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailTransaksiScreen(idTransaksi: idOrder)));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Detail Transaksi',
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Kembali',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _setAlertDelete(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Text(
            'Hapus Keranjang?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red[600],
            ),
          ),
        ),
        content: Text("Aksi ini akan membatalkan transaksi",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600])),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    margin: EdgeInsets.all(1),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(color: Colors.grey[600]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Tidak',
                        style: TextStyle(color: Colors.grey[600]!),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<CartCubit>().clearCart();

                    Navigator.pop(context);
                    Navigator.pop(context);

                    context.read<ProductCubit>().loadProducts();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Hapus',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
