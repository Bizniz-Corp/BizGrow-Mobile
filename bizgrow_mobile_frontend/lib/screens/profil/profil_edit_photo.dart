import 'dart:io';
import 'package:bizgrow_mobile_frontend/themes/colors.dart';
import 'package:bizgrow_mobile_frontend/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:bizgrow_mobile_frontend/themes/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bizgrow_mobile_frontend/themes/text_styles.dart';

class ProfilEditPhotoScreen extends StatefulWidget {
  @override
  _ProfilEditPhotoScreenState createState() => _ProfilEditPhotoScreenState();
}

class _ProfilEditPhotoScreenState extends State<ProfilEditPhotoScreen> {
  File? _image; // Variable to hold the selected image
  final picker = ImagePicker();

  // Function to pick an image from gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to pick an image from camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to show the bottom sheet to select image source
  void _showImageSourceSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Kamera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Monochrome.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                style: Regular.body.withColor(Monochrome.white),
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
                  ? Center(child: Text('Belum ada fotonya kocak')) // Placeholder text
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Rounded corners for image
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _showImageSourceSelector, // Show the option to select source
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

