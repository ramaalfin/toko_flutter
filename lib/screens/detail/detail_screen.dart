import 'package:flutter/material.dart';

class ProdukDetail extends StatelessWidget {
  String kodeProduk;
  String namaProduk;
  int hargaProduk;
  
  ProdukDetail({Key? key, required this.kodeProduk, required this.namaProduk, required this.hargaProduk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Detail"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, 
        icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
           Text("kode produk ${kodeProduk}"),
           Text("nama produk ${namaProduk}"),
           Text("harga produk ${hargaProduk.toString()}"),
          ],
        ),
      )
    );
  }
}