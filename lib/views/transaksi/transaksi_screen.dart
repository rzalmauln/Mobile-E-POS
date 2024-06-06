import 'package:e_pos/views/transaksi/detail_transaksi_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  List<int> listId = [121212, 2121223, 43554]; // placeholder
  List<int> listTotal = [289238, 328123, 2323]; // placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        leading: IconButton(
          onPressed: () {}, // GANTI UNTUK OPEN DRAWER
          splashColor: Colors.transparent,
          icon: const Icon(Iconsax.textalign_left),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
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
              ListView.builder(
                itemCount: 3, // GANTI JUMLAH ITEM
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
                                builder: (context) => DetailTransaksiScreen(
                                    idTransaksi: 21212212)));
                      },
                      idTransaksi: listId[index], // GANTI ID TRANSAKSI
                      tglTransaksi: DateTime.now(), // GANTI TANGGAL TRANSAKSI
                      totalTransaksi:
                          listTotal[index], // GANTI TOTAL BIAYA TRANSAKSI
                    ),
                  );
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
