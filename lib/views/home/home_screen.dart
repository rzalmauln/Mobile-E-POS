import 'dart:async';

import 'package:e_pos/core/color_values.dart';
import 'package:e_pos/cubits/cart/cart_cubit.dart';
import 'package:e_pos/cubits/cart/cart_item.dart';
import 'package:e_pos/cubits/cart/cart_state.dart';
import 'package:e_pos/cubits/product/product_cubit.dart';
import 'package:e_pos/cubits/product/product_state.dart';
import 'package:e_pos/data/model/product/product.dart';
import 'package:e_pos/views/keranjang/order_view.dart';
import 'package:e_pos/views/stock/widgets/modal_create.dart';
import 'package:e_pos/widgets/custom_text_field.dart';
import 'package:e_pos/widgets/navigator_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(
        () {}); // Update state setelah SharedPreferences berhasil diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().loadProducts();
    return prefs == null
        ? CircularProgressIndicator()
        : // Atau widget lain sebagai indikator loading
        Scaffold(
            drawer: const NavigatorDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bisnis:",
                      style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                          color: ColorValues.grayscale50,
                          fontSize: 11,
                        ),
                      )),
                  Text(
                    prefs!.getString('nameStore').toString(),
                    style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                          color: ColorValues.grayscale50,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    // child: CustomTextField(
                    //   controller: _controller,
                    //   hintText: 'Cari Produk',
                    //   suffixIcon: SvgPicture.asset(
                    //       'assets/icons/search-normal.svg',
                    //       colorFilter: const ColorFilter.mode(
                    //           Colors.grey, BlendMode.srcIn)),
                    // ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BlocConsumer<ProductCubit, ProductState>(
                      listener: (context, state) {
                        if (state is ErrorProductState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                            ),
                          );
                        }
                        if (state is LoadedProductState) {
                          context
                              .read<CartCubit>()
                              .setCartFromProducts(state.products);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoadingProductState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is LoadedProductState) {
                          var products = state.products;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              var product = products[index];
                              return _buildCard(product, context);
                            },
                          );
                        }
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: const Center(
                            child: Text(
                              "Anda Belum Menambah Produk",
                              style: TextStyle(
                                fontSize: 17,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: MyBottomBar(),
          );
  }

  Widget _buildCard(Product product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "Stock : ${product.stock}",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500]),
                  ),
                ),
                Text(
                  "Rp ${product.price}",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue[600]),
                ),
              ],
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final cartItem = state.items.firstWhere(
                  (item) => item.product.id == product.id,
                  orElse: () => CartItem(product: product, quantity: 0),
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
                              .decreaseItemQuantity(product.id);
                        }
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: cartItem.quantity > 0
                              ? Colors.blue[600]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: cartItem.quantity > 0
                              ? Colors.white
                              : Colors.grey[500],
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
                            .increaseItemQuantity(product.id);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: cartItem.quantity < cartItem.product.stock
                              ? Colors.blue[600]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.add,
                          color: cartItem.quantity < cartItem.product.stock
                              ? Colors.white
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return BottomAppBar(
          color: context.read<CartCubit>().getAllQuantity() == 0
              ? Colors.grey[300]
              : Colors.blue[600],
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Container(
                height: 120.0,
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Keranjang:\n${context.read<CartCubit>().getAllQuantity().toString()} Produk',
                      style: TextStyle(
                          color: context.read<CartCubit>().getAllQuantity() == 0
                              ? Colors.grey[400]
                              : Colors.white,
                          fontSize: 16.0),
                    ),
                    Row(
                      children: [
                        Text(
                          'Rp. ${context.read<CartCubit>().getTotalPrice().toString()}',
                          style: TextStyle(
                              color:
                                  context.read<CartCubit>().getAllQuantity() ==
                                          0
                                      ? Colors.grey[400]
                                      : Colors.white,
                              fontSize: 16.0),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color:
                                context.read<CartCubit>().getAllQuantity() == 0
                                    ? Colors.grey[400]
                                    : Colors.white,
                          ),
                          onPressed: () {
                            context.read<CartCubit>().getAllQuantity() == 0
                                ? context
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OrderView(),
                                    ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
