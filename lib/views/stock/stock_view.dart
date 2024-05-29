import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class StockView extends StatefulWidget {
  const StockView({super.key});

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  final stock = [
    {
      "title": "Sabun mandi",
      "qty": 20,
      "price": 8000,
    },
    {
      "title": "Shampoo",
      "qty": 10,
      "price": 10000,
    },
    {
      "title": "Pasta Gigi",
      "qty": 15,
      "price": 5000,
    },
    {
      "title": "Sikat Gigi",
      "qty": 30,
      "price": 3000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
    {
      "title": "Tissue",
      "qty": 50,
      "price": 2000,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildActionButton(
            icon: Icons.file_download_outlined,
            label: "Import Data",
            onTap: () {
              // Action for importing data
            },
          ),
          SizedBox(height: 12),
          _buildActionButton(
            icon: Icons.add,
            label: "Tambah Produk",
            onTap: () {
              // Action for adding new product
            },
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          'Stock & Inventori',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: stock.length,
                itemBuilder: (context, index) {
                  var item = stock[index];
                  return _buildCard(item['title'].toString(),
                      item['qty'] as int, item['price'] as int);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, int qty, int price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "Stock : ${qty}",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Text(
                  "Rp ${price}",
                  style: TextStyle(color: Colors.blue[600]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: Colors.yellow[500]),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline_rounded,
                      color: Colors.red[500]),
                  onPressed: () {
                    _setAlertDelete(context, title);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.blue[600],
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 12),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Future<bool> _setAlertDelete(BuildContext context,String title) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Text(
            'Hapus Produk?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red[600],
            ),
          ),
        ),
        content: Text("Aksi ini akan menghapus produk ${title} dari Stok & Inventori",
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
              SizedBox(width: 12,),
              Expanded(
                child: GestureDetector(
                  onTap: () {
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