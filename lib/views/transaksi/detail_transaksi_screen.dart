import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailTransaksiScreen extends StatefulWidget {
  final int idTransaksi;
  const DetailTransaksiScreen({super.key, required this.idTransaksi});

  @override
  State<DetailTransaksiScreen> createState() => _DetailTransaksiScreenState();
}

class _DetailTransaksiScreenState extends State<DetailTransaksiScreen> {
  List<int> qty = [1, 2, 3, 4, 3];
  List<String> item = [
    "rofafgsgfsgdti",
    "fafafasgsgsbc",
    "deadfsggfgsaf",
    "ghafagsgsfdfafi",
    "jfadafgsgsgfgrkl"
  ];
  List<int> harga = [1222121, 1221212, 2132321, 212122, 3212123];

  @override
  Widget build(BuildContext context) {
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
                _buildInfoTransaksi(
                  idTransaksi: widget.idTransaksi,
                  tglTransaksi: DateTime.now(), // GANTI TANGGAL TRANSAKSI
                ),
                const SizedBox(height: 24),
                _buildListItem(
                  // GANTI INFORMASI ITEM
                  jumlahItem: 5,
                  qty: qty,
                  item: item,
                  harga: harga,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(thickness: 1),
                ),
                _buildTotalTransaksi(
                    total: 212121,
                    bayar: 2322331,
                    kembalian: 0), // GANTI TOTAL AKHIR TRANSAKSI
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildTotalTransaksi(
      {required int total, required int bayar, required int kembalian}) {
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Bayar",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                NumberFormat.decimalPattern('id').format(bayar),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kembalian",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Text(
                NumberFormat.decimalPattern('id').format(kembalian),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildListItem(
      {required int jumlahItem,
      required List<int> qty,
      required List<String> item,
      required List<int> harga}) {
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
          itemCount: jumlahItem,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      qty[index].toString(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Text(
                      item[index],
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 2,
                    child: Text(
                      NumberFormat.decimalPattern('id').format(harga[index]),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
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
