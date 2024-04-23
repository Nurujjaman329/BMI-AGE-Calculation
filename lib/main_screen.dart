import 'package:flutter/material.dart';
import 'package:google_map_practise/bmi/age_calculator_screen.dart';
import 'package:google_map_practise/bmi/bmi_pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BMICalculation()));
              },
              child: Container(
                height: 40.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'BMI Calculation',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AgeCalculatorHomePage()));
              },
              child: Container(
                height: 40.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'Age Calculation',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
