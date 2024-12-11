import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:produkform/models/mproduk.dart';
import 'package:produkform/models/api.dart';
import 'package:produkform/form.dart';

class Edit extends StatefulWidget{
  final ProdukModel sw;

  Edit({required this.sw});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditState();
  }

}
class EditState extends State<Edit>{
  final formkey = GlobalKey<FormState>();

  late TextEditingController kodeProdukController, namaController, hargaController;

  Future editSw() async {
    return await http.post(
      Uri.parse(Baseurl.edit),
      body: {
        "id" : widget.sw.id.toString(),
        "kode_produk" : kodeProdukController.text,
        "nama" : namaController.text,
        "harga" : hargaController.text,
      },
    );
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil disimpan :v",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    kodeProdukController = TextEditingController(text: widget.sw.kode_produk);
    namaController = TextEditingController(text: widget.sw.nama);
    hargaController = TextEditingController(text: widget.sw.harga.toString());
    super.initState();
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT PRODUK'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar:  BottomAppBar(
        child: ElevatedButton(
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          onPressed: () {
            _onConfirm(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: AppForm(
            formkey: formkey,
            kodeProdukController: kodeProdukController,
            namaController: namaController,
            hargaController: hargaController,
          ),
        ),
      ),

    );
  }

}
