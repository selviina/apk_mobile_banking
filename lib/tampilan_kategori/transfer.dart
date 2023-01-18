import 'package:flutter/material.dart';
import 'package:apk_mobile_banking/service/list_users_service.dart';
import 'package:apk_mobile_banking/model/list_users_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
                  showNotification();
                },
                child: Text("Transfer"))
          ],
        ),
      ),
    );
  }

  showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high channel',
      'Very important notification!!',
      description: 'the first notification',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin.show(
        1,
        'Undiksha Banking',
        'Transfer Berhasil',
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description),
        ));
  }
}
