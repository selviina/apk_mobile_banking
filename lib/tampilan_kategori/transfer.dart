import 'package:flutter/material.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  String nama_penerima = "";
  String nomor_rekening_penerima = "";
  String jumlah_transfer = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setoran'),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama Penerima'),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                          hintText: "Masukkan Nama Penerima",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Nomor Rekening Penerima'),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                          hintText: "Masukkan Nomor Rekening",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Jumlah Transfer'),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                          hintText: "Masukkan Nominal Transfer",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                        )),
                      ],
                    )))));
  }
}
