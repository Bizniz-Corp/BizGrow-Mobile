import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PenjualanInputManualScreen extends StatefulWidget {
  const PenjualanInputManualScreen({super.key});

  @override
  _PenjualanInputManualScreenState createState() =>
      _PenjualanInputManualScreenState();
}

class _PenjualanInputManualScreenState
    extends State<PenjualanInputManualScreen> {
  DateTime selectedDate = DateTime.now();
  // late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    // _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');

    // const InitializationSettings initializationSettings =
    //     InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   // iOS settings can be added here if needed
    // );

    // await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Input Data Penjualan"),
        ),
        body: Container(
            margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
            child: Column(
              children: [
                Text("Input Data Manual",
                    style: Regular.h3.withColor(Monochrome.whiteDarkMode)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterDateOption(
                      title: 'Tanggal',
                      selectedDate: selectedDate,
                      onSelectDate: () => _selectDate(context, true),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Nama Produk",
                          style: TextStyle(color: Monochrome.whiteDarkMode))),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nama Produk',
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Harga",
                          style: TextStyle(color: Monochrome.whiteDarkMode))),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Harga',
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Kuantitas",
                          style: TextStyle(color: Monochrome.whiteDarkMode))),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Kuantitas',
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Main.lightBlue),
                          onPressed: () {
                            //  save data
                            _showNotification(); //local push notif hopefully
                          },
                          child: Text("Kirim Data",
                              style: Regular.body
                                  .withColor(Monochrome.whiteDarkMode))),
                    ),
                  )
                ]),
              ],
            )),
        bottomNavigationBar: MainNavigator(selectedIndex: 1));
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          selectedDate = pickedDate;
        }
      });
    }
  }

  Future<void> _showNotification() async {
    // const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails(
    //   'channelId',
    //   'channelName',
    //   channelDescription: 'lorem ipsum dolor sit amet',
    //   importance: Importance.high,
    //   priority: Priority.high,
    //   showWhen: false,
    // );

    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);

    // await _flutterLocalNotificationsPlugin.show(
    //   0,
    //   'Data Terkirim',
    //   'Data penjualan Anda telah berhasil dikirim.',
    //   platformChannelSpecifics,
    // );
  }
}

class FilterDateOption extends StatelessWidget {
  final String title;
  final DateTime selectedDate;
  final VoidCallback onSelectDate;

  const FilterDateOption({
    required this.title,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMMM yyyy').format(selectedDate);
    return GestureDetector(
      onTap: onSelectDate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child:
                Text(title, style: SemiBold.body.withColor(Monochrome.white)),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Center(
              child: Text(formattedDate,
                  style: Regular.body.withColor(Monochrome.white)),
            ),
          ),
        ],
      ),
    );
  }
}
