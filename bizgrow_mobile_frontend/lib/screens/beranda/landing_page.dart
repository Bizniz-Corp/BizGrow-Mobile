import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          decoration: BoxDecoration(
            color: Color(0xFF1D1B46),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'lib/assets/navbar_icon/logo1.png', // Pastikan path logo benar
                height: 120,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 24),

              // Tagline atau informasi aplikasi
              Text(
                'BizGrow',
                style: GoogleFonts.montserrat(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Empowering Your Business with Smart Predictions',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // Tombol Sign In dan Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signIn');
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4E69BA),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 5,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUp');
                    },
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4E69BA),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Fitur utama dengan CarouselSlider
              Text(
                'Our Features',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                ),
                items: [
                  featureCard(
                    context,
                    'Demand Prediction',
                    'Predict future demand to optimize your stock and avoid shortages.',
                    'lib/assets/navbar_icon/landing_page1.png',
                  ),
                  featureCard(
                    context,
                    'Profit Prediction',
                    'Analyze profit trends to make informed financial decisions.',
                    'lib/assets/navbar_icon/landing_page1.png',
                  ),
                  featureCard(
                    context,
                    'Sales History Tracking',
                    'Review past sales data to better understand customer behavior.',
                    'lib/assets/navbar_icon/landing_page1.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget featureCard(BuildContext context, String title, String description, String imagePath) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2D2F7E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
