import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:produkform/details.dart';
import 'package:produkform/models/mproduk.dart';
import 'package:produkform/models/api.dart';

import 'package:http/http.dart' as http;
import 'package:produkform/tambah_produk.dart';

class ProdukForm extends StatefulWidget{
  const ProdukForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProdukFormState();

}
class _ProdukFormState extends State<ProdukForm>{
  late Future<List<ProdukModel>> sw;
  final swListkey = GlobalKey<_ProdukFormState>();

  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ProdukModel>> getSwList() async {
    final response = await http.get(Uri.parse(Baseurl.data));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ProdukModel> sw = items.map<ProdukModel>((json) {
      return ProdukModel.fromJson(json);
    }).toList();
    return sw;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('DAFTAR PRODUK'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<ProdukModel>>(
          future : sw,
          builder:(BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.shopping_bag),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.nama,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(" Rp. "+ data.harga.toString()),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Details(sw: data)
                      ));
                    },
                  ),
                );
              },
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        hoverColor: Colors.green,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_){
              return TambahProduk();
            }),
          );
        },
      ),
    );
  }

}
