import 'dart:io'; // For File
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:image_picker/image_picker.dart';

class ProfilEditPhotoScreen extends StatefulWidget {
  @override
  _ProfilEditPhotoScreenState createState() => _ProfilEditPhotoScreenState();
}

class _ProfilEditPhotoScreenState extends State<ProfilEditPhotoScreen> {
  File? _image; // Variable to hold the selected image

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource
            .gallery); // You can change to ImageSource.camera for camera access

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Container(
        margin: EdgeInsets.all(BizGrowTheme.getMargin(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'Upload Image',
                style: GoogleFonts.montserrat(
                    fontSize: 28,
                    color: Monochrome.whiteDarkMode,
                    letterSpacing: -1),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity, // Full width
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Monochrome.lightGrey, // Background color
                borderRadius: BorderRadius.circular(8), // Rounded corners
                border: Border.all(
                  color: Monochrome.grey, // Border color
                  width: 2, // Border width
                ),
              ),
              child: _image == null
                  ? Center(
                      child:
                          Text('Belum ada fotonya kocak')) // Placeholder text
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8), // Rounded corners for image
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _pickImage, // Call _pickImage when pressed
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Main.blueSecondary,
                  foregroundColor: Monochrome.white,
                ),
                child: Text('Unggah Foto'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainNavigator(selectedIndex: 3),
    );
  }
}
