import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:produkform/models/api.dart'; // You might not need this, depending on your project
import 'package:http/http.dart' as http;

class TambahProduk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TambahProdukState();
  }
}

class TambahProdukState extends State<TambahProduk> {
  final formkey = GlobalKey<FormState>();

  TextEditingController kodeProdukController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  Future createSw() async {
    return await http.post(
      Uri.parse(Baseurl.tambah),
      body: {
        "kode_produk": kodeProdukController.text,
        "nama": namaController.text,
        "harga": hargaController.text,
      },
    );
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TAMBAH PRODUK'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: <Widget>[
                // Input field for Kode Produk
                TextFormField(
                  controller: kodeProdukController,
                  decoration: InputDecoration(
                    labelText: 'Kode Produk',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.code), // Add an icon here
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Kode Produk';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Input field for Nama
                TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.local_offer), // Add an icon here
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Produk';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Input field for Harga
                TextFormField(
                  controller: hargaController,
                  decoration: InputDecoration(
                    labelText: 'Harga Produk',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money), // Add an icon here
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Harga Produk';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: ElevatedButton(
              child: Text("Simpan"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  print("OK SUKSES");
                  _onConfirm(context);
                }
              },
            ),
            ),
        );
    }
}
