import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:test_project_fluuter1/screens/screens/onboarding.dart';
import 'package:test_project_fluuter1/screens/screens/resetPass.dart';
import 'package:test_project_fluuter1/screens/screens/signUp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1525), // Dark background
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign in",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Email TextField
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Email Address",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15),

            // Password TextField
            TextField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey.shade400),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9E60E6), // Purple
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),

            // Dont have an account? create one
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: "Create one",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signUpPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Forgot Password? Reset
            Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(text: "Forgot Password? "),
                    TextSpan(
                      text: "Reset",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => resetPass()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),

            // Social Login Buttons
            SocialButton(icon: Icons.apple, text: "Continue With Apple"),
            SizedBox(height: 10),
            SocialButton(icon: Icons.g_mobiledata, text: "Continue With Google"),
            SizedBox(height: 10),
            SocialButton(icon: Icons.facebook, text: "Continue With Facebook"),
          ],
        ),
      ),
    );
  }
}

// Custom Social Button Widget
class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const SocialButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle social login
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.white, size: 30), // Increased size
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 30), // Spacer to balance layout
        ],
      ),
    );
  }
}
