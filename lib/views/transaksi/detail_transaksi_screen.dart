import 'package:e_pos/cubits/order/order_cubit.dart';
import 'package:e_pos/cubits/order/order_state.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_cubit.dart';
import 'package:e_pos/cubits/orderDetail/orderDetail_state.dart';
import 'package:e_pos/cubits/product/product_cubit.dart';
import 'package:e_pos/data/model/order/order.dart';
import 'package:e_pos/data/model/order_detail/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailTransaksiScreen extends StatefulWidget {
  final int idTransaksi;
  const DetailTransaksiScreen({super.key, required this.idTransaksi});

  @override
  State<DetailTransaksiScreen> createState() => _DetailTransaksiScreenState();
}

class _DetailTransaksiScreenState extends State<DetailTransaksiScreen> {
  String productName = '';

  Future<String> getNameProduct(OrderDetail orderDetails) async {
    String isi = await context
        .read<ProductCubit>()
        .getProductName(orderDetails.productId);
    return isi;
  }

  void setString(OrderDetail orderDetails) async {
    this.productName = await getNameProduct(orderDetails);
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrderDetailCubit>().getOrderDetail(widget.idTransaksi);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: Text(
          "INV-${widget.idTransaksi}",
          style: const TextStyle(fontWeight: FontWeight.w100, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.asset('assets/icons/receipt.svg'),
                    ),
                    const Text(
                      "Rincian Transaksi",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    if (state is LoadedOrderState) {
                      return _buildInfoTransaksi(
                        idTransaksi: widget.idTransaksi,
                        tglTransaksi:
                            state.orders[widget.idTransaksi - 1].orderDate,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<OrderDetailCubit, OrderDetailState>(
                  builder: (context, state) {
                    if (state is LoadedOrderDetailState) {
                      return _buildListItem(state.orderDetails);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(thickness: 1),
                ),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    if (state is LoadedOrderState) {
                      return _buildTotalTransaksi(
                        total: state.orders[widget.idTransaksi - 1].total,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ), // GANTI TOTAL AKHIR TRANSAKSI
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildTotalTransaksi({required int total}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                NumberFormat.decimalPattern('id').format(total),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildListItem(List<OrderDetail> orderDetails) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "Qty",
                  style: TextStyle(
                      color: Color(0xFF64748B), fontWeight: FontWeight.w400),
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  "Item",
                  style: TextStyle(
                      color: Color(0xFF64748B), fontWeight: FontWeight.w400),
                ),
              ),
              Spacer(),
              Flexible(
                flex: 2,
                child: Text(
                  "Harga",
                  style: TextStyle(
                      color: Color(0xFF64748B), fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          itemCount: orderDetails.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return orderDetails[index].qty == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Text(
                            orderDetails[index].qty.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: FutureBuilder<String>(
                              future: getNameProduct(orderDetails[index]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                if (snapshot.data != "") {
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  );
                                }
                                return Text("data");
                              }),
                        ),
                        const Spacer(),
                        Flexible(
                          flex: 2,
                          child: Text(
                            NumberFormat.decimalPattern('id')
                                .format(orderDetails[index].price),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }

  Column _buildInfoTransaksi(
      {required int idTransaksi, required DateTime tglTransaksi}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ID TRANSAKSI",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                "INV-$idTransaksi",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tanggal Transaksi",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('dd/MMM/yyyy').format(tglTransaksi),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
