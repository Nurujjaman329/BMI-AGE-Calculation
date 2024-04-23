import 'dart:developer';

import 'package:flutter/material.dart';

class AgeCalculatorHomePage extends StatefulWidget {
  @override
  _AgeCalculatorHomePageState createState() => _AgeCalculatorHomePageState();
}

class _AgeCalculatorHomePageState extends State<AgeCalculatorHomePage> {
  late DateTime _selectedDate;
  String _ageYears = '';
  String _ageMonths = '';
  String _ageDays = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _calculateAge(); // Call calculateAge function after selecting the date
    }
  }

  void _calculateAge() {
    final now = DateTime.now();

    int years = now.year - _selectedDate.year;
    int months = now.month - _selectedDate.month;
    int days = now.day - _selectedDate.day;

    log('Months->' + months.toString());

    // Adjust negative months
    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      if (months < 0) {
        months += 12;
      }
    }
    log('Days -> ' + days.toString());
    // Adjust negative days
    if (days < 0) {
      final DateTime lastMonthDate =
          DateTime(now.year, now.month - 1, _selectedDate.day);
      days = now.difference(lastMonthDate).inDays;
    }

    setState(() {
      _ageYears = years.toString();
      _ageMonths = months.toString();
      _ageDays = days.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calculateAge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text(
              'Your Age: $_ageYears years, $_ageMonths months, $_ageDays days',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
