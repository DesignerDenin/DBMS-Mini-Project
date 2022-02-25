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
  late Map<String, double> dataMap = {
    "Infected": widget.data.sickNo.toDouble(),
    "Healthy":
        widget.data.totCitizens.toDouble() - widget.data.sickNo.toDouble(),
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

  DateTime fromJulian(int jd) {
    int day = jd % 1000;
    int year = (jd - day) ~/ 1000;
    var date1 = DateTime(year, 1, 1);
    return date1.add(Duration(days: day - 1));
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
                    colorList: [Colors.blue[200]!, Colors.blue[500]!],
                  )),
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[500]!),
                    borderRadius: const BorderRadius.all(Radius.circular(21))),
                child: Column(
                  children: [
                    Text(
                      'Your Personal information:',
                      style: TextStyle(fontSize: fontSize()),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 60)),
                    Text("Name: ${widget.data.name}"),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    Text("Age: ${widget.data.age}"),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    Text("Gender: ${getGender()}"),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 50)),
              widget.data.aDate != null
                  ? Container(
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue[500]!),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(21))),
                      child: Column(
                        children: [
                          Text(
                            'Your next vaccination appoinment:',
                            style: TextStyle(fontSize: fontSize()),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 60)),
                          Text("Center name: ${widget.data.aName}"),
                          const Padding(padding: EdgeInsets.only(bottom: 30)),
                          Text("Center location: ${widget.data.aLocation}"),
                          const Padding(padding: EdgeInsets.only(bottom: 30)),
                          Text("Date: ${fromJulian(widget.data.aDate!)}"),
                          const Padding(padding: EdgeInsets.only(bottom: 30)),
                        ],
                      ),
                    )
                  : Container(),
              const Padding(padding: EdgeInsets.only(bottom: 50)),
            ],
          )),
        ));
  }
}
