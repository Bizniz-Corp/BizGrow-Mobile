import 'package:bizgrow_mobile_frontend/screens/profil/profil_edit.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign in/sign in.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Monochrome.lightGrey,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Monochrome.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Nama',
              style: Regular.h2.withColor(Monochrome.whiteDarkMode),
            ),
            // DI SINI INPUT BORDER
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Budi',
                labelStyle: TextStyle(
                  color: Monochrome.white,
                ),
                hintStyle: TextStyle(
                  color: Monochrome.white,
                ),
                fillColor: Main.lightBlue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Border melengkung
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Email',
                style: Regular.h2.withColor(Monochrome.whiteDarkMode)),
            // DI SINI INPUT BORDER
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'a@gmail.com', // Placeholder
                labelStyle: TextStyle(
                  color: Monochrome.white, // Warna label
                ),
                hintStyle: TextStyle(
                  color: Monochrome.white, // Warna placeholder
                ),
                fillColor: Main.lightBlue,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Border melengkung
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilEditScreen()));
                  },
                  child: Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Main.blueSecondary,
                    foregroundColor: Monochrome.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Konfirmasi Hapus Akun'),
                          content: Text(
                              'Apakah Anda yakin ingin menghapus akun ini?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Batal',
                                )),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                );
                                // Belum diisi karena menunggu api dari website
                              },
                              child: Text('Hapus Akun',
                                  style: Regular.body
                                      .withColor(additionalColor.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Hapus Akun'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: additionalColor.red,
                    foregroundColor: Monochrome.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Konfirmasi Keluar'),
                        content: Text('Apakah Anda yakin ingin keluar?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              apiService.logout();
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: Text('Keluar',
                                style: Regular.body
                                    .withColor(additionalColor.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: additionalColor.red,
                  foregroundColor: Monochrome.white,
                ),
                child: Text('Keluar'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
