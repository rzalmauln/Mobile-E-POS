import 'dart:math';

import 'package:e_pos/core/color_values.dart';
import 'package:e_pos/cubits/product/product_cubit.dart';
import 'package:e_pos/cubits/product/product_state.dart';
import 'package:e_pos/data/model/product/product.dart';
import 'package:e_pos/utils/csv_exporter.dart';
import 'package:e_pos/utils/csv_importer.dart';
import 'package:e_pos/views/stock/widgets/modal_create.dart';
import 'package:e_pos/widgets/basic_app_bar.dart';
import 'package:e_pos/widgets/navigator_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  Future<void> _importCSV() async {
    try {
      CSVImporter importer = CSVImporter();
      String filePath = await importer.pickFile();

      if (filePath.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: ColorValues.danger500,
          content: Text('Gagal mengimport data, mohon coba lagi'),
        ));
        return;
      }

      List<Map<String, dynamic>> data = await importer.readCSV(filePath);

      print('CSV DATA: ${data}');
      Product object;
      for (Map<String, dynamic> datas in data) {
        object = Product.fromJson(datas);
        print('OBJECT: $object');

        context
            .read<ProductCubit>()
            .addProduct(object.name, object.stock, object.price);
      }
    } catch (e) {
      print('Error importing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().loadProducts();

    return Scaffold(
      drawer: const NavigatorDrawer(),
      floatingActionButton: _buildActionButton(
        icon: Icons.add,
        label: "Tambah Produk",
        onTap: () {
          _showAddDialog();
        },
      ),
      appBar: const BasicAppBar(title: "Stock & Inventori"),
      body: SingleChildScrollView(
          child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ErrorProductState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingProductState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is LoadedProductState) {
                    var products = state.products;

                    return products.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                _buildExportImportBtn(products),
                                Text(
                                  "Inventori anda kosong",
                                  style: TextStyle(
                                    fontSize: 17,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: _buildExportImportBtn(products),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  var product = products[index];
                                  return _buildCard(product.name, product.stock,
                                      product.price, product.id);
                                },
                              ),
                            )
                          ]);
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
              ))),
    );
  }

  Widget _buildExportImportBtn(List<Object> data) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      // margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            icon: Icons.file_upload_outlined,
            label: "Ekspor Data",
            onTap: () async {
              if (data.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: ColorValues.danger500,
                  content: Text('Gagal mengekspor data'),
                ));
                return;
              }

              CSVExporter exporter = CSVExporter();
              try {
                await exporter.exportToCSV('products', data);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: ColorValues.danger500,
                  content: Text('Gagal mengekspor data, mohon coba lagi'),
                ));
                print('Error exporting: $e');
              } finally {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: ColorValues.success500,
                  content: Text('Berhasil mengekspor data pada /Downloads'),
                ));
              }
            },
          ),
          _buildActionButton(
            icon: Icons.file_download_outlined,
            label: "Import Data",
            onTap: () async {
              try {
                await _importCSV();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Gagal mengimport data'),
                    backgroundColor: ColorValues.danger500,
                  ),
                );
              } finally {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Berhasil mengimport data'),
                    backgroundColor: ColorValues.success500,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, int qty, int price, int id) {
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 50.w,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  "Stock : ${qty}",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[500]),
                ),
                Text(
                  "Rp ${price}",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[600]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: Colors.yellow[500]),
                  onPressed: () {
                    _showEditDialog(id, title, qty, price);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline_rounded,
                      color: Colors.red[500]),
                  onPressed: () {
                    _setAlertDelete(context, title, id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ModalCreateStock(
          isEdit: false,
        );
      },
    );
  }

  void _showEditDialog(int id, String name, int stock, int price) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ModalCreateStock(
          isEdit: true,
          idProduct: id,
          name: name,
          stock: stock,
          price: price,
        );
      },
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.blue[600],
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(label,
                style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: -0.32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _setAlertDelete(BuildContext context, String title, int id) async {
    await showDialog(
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
        content: Text(
            "Aksi ini akan menghapus produk $title dari Stok & Inventori",
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
                    margin: const EdgeInsets.all(1),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
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
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<ProductCubit>().deleteProduct(id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berhasil menghapus $title'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
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
