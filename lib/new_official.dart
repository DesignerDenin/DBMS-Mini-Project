import 'dart:ffi';

import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOfficial extends StatefulWidget {
  final RustImpl api;
  const NewOfficial({Key? key, required this.api}) : super(key: key);

  @override
  State<NewOfficial> createState() => NewOfficialState();
}

class NewOfficialState extends State<NewOfficial> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<ID> addCitizen(name, password, age, gender) => widget.api
      .addCitizen(name: name, password: password, age: age, gender: gender);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Official'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Official\'s name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: ElevatedButton(
              child: const Text(
                'Register New Official',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {},
            ),
          ),
        ],
      )),
    );
  }
}
