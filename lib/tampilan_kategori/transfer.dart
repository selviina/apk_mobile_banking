import 'package:flutter/material.dart';
import 'package:apk_mobile_banking/service/list_users_service.dart';
import 'package:apk_mobile_banking/model/list_users_model.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key, required this.user}) : super(key: key);
  final ListUsersModel user;
  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  TextEditingController nomor_rekeningController = TextEditingController();
  TextEditingController jumlah_setoranController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setoran'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: nomor_rekeningController,
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
            TextField(
              controller: jumlah_setoranController,
              decoration: InputDecoration(
                hintText: "Masukkan Nominal Transfer",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ListUsersService _service = ListUsersService();
                  _service.PostTransfer(
                      int.parse(widget.user.user_id.toString()),
                      double.parse(jumlah_setoranController.text),
                      nomor_rekeningController.text);
                },
                child: Text("Transfer"))
          ],
        ),
      ),
    );
  }
}
