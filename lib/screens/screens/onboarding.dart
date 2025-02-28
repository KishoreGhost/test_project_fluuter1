import 'package:flutter/material.dart';
import 'package:test_project_fluuter1/screens/screens/firstPage.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  String selectedGender = "Men";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1525),

      // Todo: remove this appbar after full design
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Text(
              "Tell us About yourself",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 30),
            
            // Gender Selection
            Text("Who do you shop for?", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            Row(
              children: [
                genderButton("Men"),
                SizedBox(width: 10),
                genderButton("Women"),
              ],
            ),
            
            SizedBox(height: 30),

            // Age Range
            Text("How Old are you?", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                dropdownColor: Colors.grey.shade900,
                value: "Age Range",
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                underline: SizedBox(),
                onChanged: (String? newValue) {},
                items: ["Age Range", "18-24", "25-34", "35-44", "45+"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
              ),
            ),

            Spacer(),

            // Finish Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => Firstpage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8F5FE8),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                "Finish",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget genderButton(String text) {
    bool isSelected = selectedGender == text;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = text;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF8F5FE8) : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
