import 'package:e_pos/cubits/cart/cart_cubit.dart';
import 'package:e_pos/cubits/cart/cart_state.dart';
import 'package:e_pos/views/keranjang/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xffb2563eb),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            height: 60.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${context.read<CartCubit>().getAllQuantity().toString()} Produk',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  'Rp. ${context.read<CartCubit>().getTotalPrice().toString()}',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderView(),
                        ));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
