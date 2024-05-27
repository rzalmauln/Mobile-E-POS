import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StockView extends StatefulWidget {
  const StockView({super.key});

  @override
  State<StockView> createState() => _StockViewState();
}

class _StockViewState extends State<StockView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: const Text('Stock & Inventori',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal:24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [Expanded(
            
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _buildCard("Sabun", 20, 8000);
                  },
                ),
              ),
              Container(
                child: Text("Import Data", style: TextStyle(color: Colors.white)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.blue[600],
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                )
              ),
              SizedBox(height: 12,),
              Container(
                width: 188,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text("Tambah Produk", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.blue[600],
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                )
              ),


        ],),
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
                  style: TextStyle(
                      color: Colors.grey[500]),
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
                  icon: Icon(Icons.delete_outline_rounded, color: Colors.red[500]),
                  onPressed: () {},
                ),
              ],),
            // CustomNumberInputWithIncrementDecrement(value: 3, )
          ],
        ),
      ),
    );
  }
}