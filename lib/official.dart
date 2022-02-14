import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'new_citizen.dart';
import 'new_official.dart';

class Official extends StatefulWidget {
  final OfficialData data;
  const Official({Key? key, required this.data}) : super(key: key);

  @override
  State<Official> createState() => OfficialState();
}

class OfficialState extends State<Official> {
  double fontSize() {
    double width = MediaQuery.of(context).size.width;
    return width * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Official\'s summary'),
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
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewCitizen()));
                },
                child: const Text(
                  'Register new citizen',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewOfficial()));
                },
                child: const Text(
                  'Register new official',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewOfficial()));
                },
                child: const Text(
                  'Create appoinment',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewOfficial()));
                },
                child: const Text(
                  'Register new Vaccination center',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Schedule vaccination',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
          ),
        ],
      )),
    );
  }
}
