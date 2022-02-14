import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Citizen extends StatefulWidget {
  final CitizenData data;
  const Citizen({Key? key, required this.data}) : super(key: key);

  @override
  State<Citizen> createState() => CitizenState();
}

class CitizenState extends State<Citizen> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  double fontSize() {
    double width = MediaQuery.of(context).size.width;
    return width * 0.05;
  }

  String getGender() {
    if (widget.data.gender == 'F') {
      return "Female";
    } else {
      return "Male";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Citizen\'s summary'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Welcome, ' + widget.data.name + '!',
                  style: TextStyle(fontSize: fontSize()),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: PieChart(
                    dataMap: dataMap,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    colorList: [Colors.orange[200]!, Colors.orange[500]!],
                  )),
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange[500]!),
                    borderRadius: const BorderRadius.all(Radius.circular(21))),
                child: Column(
                  children: [
                    Text(
                      'Personal information:',
                      style: TextStyle(fontSize: fontSize()),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text("Name: ${widget.data.name}"),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text("Age: ${widget.data.age}"),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Text("Gender: ${getGender()}"),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
            ],
          )),
        ));
  }
}
