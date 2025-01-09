import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/edit_password.dart';
import 'package:bizgrow_mobile_frontend/screens/profil/profil_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:bizgrow_mobile_frontend/services/api_service.dart';

class ProfilEditScreen extends StatefulWidget {
  const ProfilEditScreen({super.key});

  @override
  _ProfilEditScreenState createState() => _ProfilEditScreenState();
}

class _ProfilEditScreenState extends State<ProfilEditScreen> {
  File? _profileImageFile;
  String? _profileImageUrl;
  final picker = ImagePicker();
  Map<String, dynamic> profileData = {};
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? token;
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
          _nameController.text = response['data']['data']['name'];
          _emailController.text = response['data']['data']['email'];
          _profileImageUrl = response['data']['data']['profile_picture'];
        });
        print("Profile data: $profileData");
        print("Profile image URL: $_profileImageUrl");
      } else {
        print("Error fetching data: ${response['message']}");
      }
    } catch (e) {
      print("Error loading JSON data: $e");
    }
  }

  Future<void> _updateProfile(File? profileImage, String name, String email) async {
    try {
      final response = await ApiService().updateProfile({
        'name': name,
        'email': email,
        'profile_image': profileImage != null ? profileImage.path : null,
      });

      if (response['success']) {
        print("Profile updated successfully");
      } else {
        print("Error updating profile: ${response['message']}");
      }
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImageFile = File(pickedFile.path);
      });
    }
  }

  void _showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Monochrome.darkGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Konfirmasi Simpan',
            style: SemiBold.h2.withColor(Monochrome.whiteDarkMode),
          ),
          content: Text(
            'Apakah kamu yakin ingin menyimpan perubahan?',
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilScreen()));
                _updateProfile(_profileImageFile, _nameController.text, _emailController.text);
              },
              child: Text(
                'Simpan',
                style: SemiBold.body.withColor(Main.lightBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Monochrome.whiteDarkMode),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Monochrome.lightGrey,
                        backgroundImage: _profileImageFile != null
                            ? FileImage(_profileImageFile!)
                            : _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                : null,
                        child: _profileImageFile == null && _profileImageUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Monochrome.grey,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImageSourceActionSheet,
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Nama',
                  style: SemiBold.h2.withColor(Monochrome.whiteDarkMode),
                ),
                // DI SINI INPUT BORDER
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: profileData['name'] ?? 'Nama', // Placeholder from JSON
                    hintStyle: const TextStyle(
                      color: Monochrome.grey, // Warna placeholder
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Border melengkung
                    ),
                  ),
                  style: const TextStyle(color: Monochrome.white),
                ),
                const SizedBox(height: 30),
                Text(
                  'Email',
                  style: SemiBold.h2.withColor(Monochrome.whiteDarkMode),
                ),
                // DI SINI INPUT BORDER
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: profileData['email'] ?? 'Email', // Placeholder from JSON
                    hintStyle: const TextStyle(
                      color: Monochrome.grey, // Warna placeholder
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // Border melengkung
                    ),
                  ),
                  style: const TextStyle(color: Monochrome.white),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPassword()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Main.blueSecondary,
                      foregroundColor: Monochrome.white,
                    ),
                    child: const Text('Ubah Password'),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _showSaveConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Main.blueSecondary,
                      foregroundColor: Monochrome.white,
                    ),
                    child: const Text('Simpan'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MainNavigator(selectedIndex: 3),
    );
  }
}
