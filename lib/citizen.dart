import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';

class Citizen extends StatefulWidget {
  final CitizenData data;
  const Citizen({Key? key, required this.data}) : super(key: key);

  @override
  State<Citizen> createState() => CitizenState();
}

class CitizenState extends State<Citizen> {
  double fontSize() {
    double width = MediaQuery.of(context).size.width;
    return width * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen\'s summary'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Welcome, ' + widget.data.name + '!',
              style: TextStyle(fontSize: fontSize()),
            ),
          ),
        ],
      )),
    );
  }
}
