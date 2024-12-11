import 'package:flutter/material.dart';

class ProdukDetail extends StatefulWidget{
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;

  const ProdukDetail({Key? key, this.kodeProduk, this.namaProduk, this.harga})
      :super(key: key);


  @override
  State<StatefulWidget> createState() => _ProdukDetailState();

}
class _ProdukDetailState extends State<ProdukDetail>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Kode Produk: " + widget.kodeProduk.toString()),
          Text("Nama Produk: ${widget.namaProduk}"),
          Text("Harga: ${widget.harga}")
        ],
      ),
    );
  }

}
