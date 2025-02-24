import 'package:flutter/material.dart';
import 'package:test_project_fluuter1/screens/login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E6CEF), // Corrected hex color
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()), 
          );
        },
        child: Center(
          child: Image.asset('images/LandingLogo.png'), 
        ),
      ),
    );
  }
}
