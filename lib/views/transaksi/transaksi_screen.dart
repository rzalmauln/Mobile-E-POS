import 'package:e_pos/cubits/order/order_cubit.dart';
import 'package:e_pos/cubits/order/order_state.dart';
import 'package:e_pos/views/transaksi/detail_transaksi_screen.dart';
import 'package:e_pos/widgets/navigator_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  // List<int> listId = [121212, 2121223, 43554]; // placeholder
  // List<int> listTotal = [289238, 328123, 2323]; // placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigatorDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        title: const Text(
          "Transaksi",
          style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is LoadedOrderState) {
                    return ListView.builder(
                      itemCount: state.orders.length, // GANTI JUMLAH ITEM
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 24.0),
                          child: _buildListItem(
                            context: context,
                            onTap: () {
                              // GANTI FUNCTION ON TAP
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailTransaksiScreen(
                                              idTransaksi:
                                                  state.orders[index].id)));
                            },
                            idTransaksi:
                                state.orders[index].id, // GANTI ID TRANSAKSI
                            tglTransaksi: state.orders[index]
                                .orderDate, // GANTI TANGGAL TRANSAKSI
                            totalTransaksi: state.orders[index]
                                .total, // GANTI TOTAL BIAYA TRANSAKSI
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildListItem(
      {required BuildContext context,
      required Function() onTap,
      required int idTransaksi,
      required DateTime tglTransaksi,
      required int totalTransaksi}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 88,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INV-$idTransaksi",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MMM/yyyy').format(tglTransaksi),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    "Rp. ${NumberFormat.decimalPattern('id').format(totalTransaksi)}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Iconsax.arrow_right_1,
                size: 24,
                color: Color(0xFF2563EB),
              ),
            )
          ],
        ),
      ),
    );
  }
}
