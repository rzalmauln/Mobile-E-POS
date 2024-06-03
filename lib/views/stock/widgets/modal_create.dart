import 'package:e_pos/cubits/product/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalCreateStock extends StatefulWidget {
  const ModalCreateStock(
      {super.key,
      this.name,
      this.stock,
      this.price,
      this.isEdit,
      this.idProduct});
  final String? name;
  final int? stock;
  final int? price;
  final bool? isEdit;
  final int? idProduct;

  @override
  State<ModalCreateStock> createState() => _ModalCreateStockState();
}

class _ModalCreateStockState extends State<ModalCreateStock> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    stockController = TextEditingController(text: widget.stock.toString());
    priceController = TextEditingController(text: widget.price.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    stockController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(height: 10.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text("Nama Produk",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal)),
                ),

                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Eits, masukkan nama produk dulu ya!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10.0),
                    labelStyle: TextStyle(
                      color: Colors.grey[500]!,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    labelText: "Nama",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[600]!),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text("Stok",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal)),
                ),
                TextFormField(
                  controller: stockController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Eits, masukkan stok produk dulu ya!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10.0),
                    labelStyle: TextStyle(
                      color: Colors.grey[500]!,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    labelText: "Stock",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text("Harga",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal)),
                ),
                TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Eits, masukkan harga produk dulu ya!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10.0),
                    labelStyle: TextStyle(
                      color: Colors.grey[500]!,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red[600]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Batal',
                              style: TextStyle(color: Colors.red[600]!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.isEdit!) {
                            } else {
                              context.read<ProductCubit>().addProduct(
                                  nameController.toString(),
                                  int.tryParse(stockController.text)!,
                                  int.tryParse(priceController.text)!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item Berhasil Ditambah'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              widget.isEdit! ? 'Edit' : 'Tambah',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
