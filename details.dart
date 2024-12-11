import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:produk_app/models/api.dart';
import 'package:produkform/models/mproduk.dart';
import 'package:produkform/edit.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Details extends StatefulWidget{
  final ProdukModel sw;
  Details({required this.sw});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsState();
  }

}
class DetailsState extends State<Details>{
  void deleteProduk(context) async {
    http.Response response = await http.post(
      Uri.parse(Baseurl.hapus),
      body: {
        'id': widget.sw.id.toString(),
      },
    );
    final data = json.decode(response.body);
    if(data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Data berhasil dihapus :v",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Yakin mau dihapus?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel),
              ),
              ElevatedButton(
                onPressed: () => deleteProduk(context),
                child: Icon(Icons.check_circle),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL PRODUK'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.sw.id}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "KODE PRODUK : ${widget.sw.kode_produk}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "NAMA : ${widget.sw.nama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "HARGA : Rp. ${widget.sw.harga.toString()}",
              style: TextStyle(fontSize: 20),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(sw: widget.sw),
          ),
        ),
      ),
    );
  }

}
