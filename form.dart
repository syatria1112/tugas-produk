import 'package:flutter/material.dart';

class AppForm extends StatefulWidget{
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController kodeProdukController,
      namaController,
      hargaController;

  AppForm(
      {required this.formkey,
        required this.kodeProdukController,
        required this.namaController,
        required this.hargaController}
      );

  AppFormState createState() => AppFormState();

}
class AppFormState extends State<AppForm>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          txtKodeProduk(),
          SizedBox(height: 16),
          txtNama(),
          SizedBox(height: 16),
          txtHarga(),
        ],
      ),
    );
  }
  txtKodeProduk() {
    return TextFormField(
      controller: widget.kodeProdukController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Kode Produk",
          prefixIcon: Icon(Icons.code),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Masukan Kode Produk.';
        }
        return null;
      },
    );
  }
  txtNama() {
    return TextFormField(
      controller: widget.namaController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "NAMA",
          prefixIcon: Icon(Icons.local_offer),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Masukan Nama Anda.';
        }
        return null;
      },
    );
  }
  txtHarga() {
    return TextFormField(
      controller: widget.hargaController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Harga",
          prefixIcon: Icon(Icons.attach_money),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Masukan Harga.';
        }
        return null;
      },
    );
  }
}
