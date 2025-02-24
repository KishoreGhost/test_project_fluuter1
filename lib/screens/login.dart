import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color
      (0xFF1A1525),
       // Dark background
      appBar: AppBar(),
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
            SizedBox(height: 20),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                // Handle login
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
            SizedBox(height: 20),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    // Handle "Create One"
                  },
                  child: Text(
                    "Create One",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),

            // Social Login Buttons
            SocialButton(icon: Icons.apple, text: "Continue With Apple"),
            SizedBox(height: 10),
            SocialButton(icon: (Icons.g_mobiledata), text: "Continue With Google"),
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

  SocialButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle social login
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
