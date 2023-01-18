import 'package:flutter/material.dart';
import 'package:apk_mobile_banking/service/list_users_service.dart';
import 'package:apk_mobile_banking/model/list_users_model.dart';

class Setoran extends StatefulWidget {
  final ListUsersModel user;

  const Setoran({Key? key, required this.user}) : super(key: key);

  @override
  State<Setoran> createState() => _Setoranstate();
}

class _Setoranstate extends State<Setoran> {
  TextEditingController jumlahSetoranController = TextEditingController();
  bool setorLoading = false;
  int counter = 0;

  confirmDialog(String? user_id, String jumlah_setoran) {
    showDialog(
      context: (context),
      builder: (_) => AlertDialog(
        title: Text('Apa Anda Yakin?'),
        actions: [
          (setorLoading)
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      setorLoading = true;
                    });
                    await setorSaldo(user_id, jumlah_setoran);
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
        title: Text('Setor'),
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
                    controller: jumlahSetoranController,
                    decoration: InputDecoration(labelText: "Jumlah Setoran"),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  confirmDialog(
                      widget.user.user_id, jumlahSetoranController.text);
                },
                child: Text('Setor'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setorSaldo(String? user_id, String jumlah_setoran) async {
    ListUsersService _service = ListUsersService();
    await _service.setorSaldo(
        int.parse(user_id!), double.parse(jumlah_setoran));
    setState(() {
      setorLoading = false;
    });
  }
}
