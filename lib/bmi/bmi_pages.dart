import 'dart:developer';

import 'package:flutter/material.dart';

import 'radar_painter.dart';
import 'text_input_decoration.dart';

class BMICalculation extends StatefulWidget {
  const BMICalculation({super.key});

  @override
  State<BMICalculation> createState() => _BMICalculationState();
}

class _BMICalculationState extends State<BMICalculation> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  late double _weight;
  late double _height;
  late double BMI = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _weightController,
                decoration: textInputDecoration(
                    'Weight', const Icon(Icons.monitor_weight_sharp)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill the field';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _heightController,
                decoration:
                    textInputDecoration('Height', const Icon(Icons.height)),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill the field';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _weight = double.parse(_weightController.text);
                    _height = double.parse(_heightController.text) * .3048;

                    //Calculate BMI

                    BMI = _weight / (_height * _height);

                    String weightStatus;
                    double _newWeight = 0.0;
                    double _newBMI = 0.0;
                    if (BMI >= 18.5 && BMI <= 24.9) {
                      weightStatus = 'Healthy weight -> Maintain this Weight';
                    } else if (BMI >= 25 && BMI <= 29.9) {
                      _newBMI = BMI - 24.9;
                      log("${_newBMI.toDouble()}");
                      _weight = _newBMI * (_height * _height);
                      _newWeight = _weight;
                      weightStatus = 'Overweight';
                    } else if (BMI >= 30 && BMI <= 39.9) {
                      _newBMI = BMI - 29.9;
                      log("${_newBMI.toDouble()}");
                      _weight = _newBMI * (_height * _height);
                      _newWeight = _weight;
                      weightStatus = 'Obese';
                    } else {
                      weightStatus = 'Severely obese';
                    }

                    // Show BMI value and weight status in a dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: CustomPaint(
                                    painter: RadarPainter(),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Your BMI is: ${BMI.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Weight status: $weightStatus',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Your Target Weight loose: ${_newWeight.toDouble()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  //  ScaffoldMessenger.of(context).showSnackBar(
                  //    SnackBar(
                  //      content: Text('Form is valid, proceed with calculation'),
                  //    ),
                  //  );
                  //}
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Fill This Field'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
