import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/profil_edit.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/screens/Sign in/sign in.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final List<String> entries = <String>[
    'Ubah Profil',
    'Ganti Password',
    'Keluar'
  ];
  final List<Icon> icons = <Icon>[
    Icon(Icons.edit),
    Icon(Icons.lock),
    Icon(Icons.logout)
  ];
  Map<String, dynamic> profileData = {};
  String? profileImagePath;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final response = await apiService.fetchProfile();
      print("API Response: $response");
      if (response['success'] == true) {
        setState(() {
          profileData = response['data']['data'];
          profileImagePath = response['data']['data']['profile_picture'];
        });
        print("Profile data: $profileData");
        print("Profile image path: $profileImagePath");
      } else {
        print("Error fetching data: ${response['message']}");
      }
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Monochrome.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Konfirmasi Keluar',
            style: SemiBold.h2.withColor(Monochrome.whiteDarkMode),
          ),
          content: Text(
            'Apakah kamu yakin ingin keluar?',
            style: Regular.h3.withColor(Monochrome.whiteDarkMode),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Batal',
                style: SemiBold.body.withColor(Main.lightBlue),
              ),
            ),
            TextButton(
              onPressed: _logout,
              child: Text(
                'Keluar',
                style: SemiBold.body.withColor(additionalColor.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    await apiService.logoutUser();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileImagePath != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('$profileImagePath'),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundColor: Monochrome.lightGrey,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Monochrome.grey,
                        ),
                      ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileData['name'] ?? 'Memuat...',
                      style: SemiBold.h2.withColor(Monochrome.whiteDarkMode),
                    ),
                    Text(
                      profileData['email'] ?? 'Memuat...',
                      style: Regular.h3.withColor(Monochrome.whiteDarkMode),
                    ),
                    Text(
                      profileData['npwp'] ?? 'Memuat...',
                      style: Regular.h3.withColor(Monochrome.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 48),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilEditScreen()),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPassword()),
                        );
                      } else if (index == 2) {
                        confirmLogout();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10), // Add vertical padding
                      margin: const EdgeInsets.symmetric(
                          vertical: 8), // Add vertical margin
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: index == 2
                                ? additionalColor.red
                                : Main.lightBlue,
                            child: Icon(
                              icons[index].icon,
                              color: Monochrome.whiteDarkMode,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(entries[index],
                              style: SemiBold.body
                                  .withColor(Monochrome.whiteDarkMode)),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MainNavigator(selectedIndex: 3),
    );
  }
}
