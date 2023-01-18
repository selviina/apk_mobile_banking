import 'package:flutter/material.dart';
import 'package:apk_mobile_banking/service/list_users_service.dart';
import 'package:apk_mobile_banking/model/list_users_model.dart';

class Tarikan extends StatefulWidget {
  final ListUsersModel user;

  const Tarikan({Key? key, required this.user}) : super(key: key);

  @override
  State<Tarikan> createState() => _TarikanState();
}

class _TarikanState extends State<Tarikan> {
  bool tarikanLoading = false;
  final TextEditingController jumlahTarikanController = TextEditingController();

  confirmDialog(String? user_id, String jumlah_tarikan) {
    showDialog(
      context: (context),
      builder: (_) => AlertDialog(
        title: Text('Apa Anda Yakin?'),
        actions: [
          (tarikanLoading)
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      tarikanLoading = true;
                    });
                    await tarikSaldo(user_id, jumlah_tarikan);
                    Navigator.pop(context);
                  },
                  child: Text('Ya'),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarikan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: jumlahTarikanController,
                    decoration: InputDecoration(labelText: "Jumlah Tarikan"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  confirmDialog(
                      widget.user.user_id, jumlahTarikanController.text);
                  // tarikSaldo(
                  //     widget.user.user_id, jumlahPenarikanController.text);
                },
                child: Text('Tarik'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  tarikSaldo(String? user_id, String jumlah_tarikan) async {
    ListUsersService _service = ListUsersService();
    await _service.tarikSaldo(
        int.parse(user_id!), double.parse(jumlah_tarikan));
    setState(() {
      tarikanLoading = false;
    });
  }
}
