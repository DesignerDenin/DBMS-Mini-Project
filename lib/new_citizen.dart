import 'dart:ffi';

import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const path = 'librust.so';
late final library = DynamicLibrary.open(path);
late final api = RustImpl(library);

class NewCitizen extends StatefulWidget {
  const NewCitizen({Key? key}) : super(key: key);

  @override
  State<NewCitizen> createState() => NewCitizenState();
}

class NewCitizenState extends State<NewCitizen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  var items = ["Male", "Female"];
  var genderValue = "Male";
  var isInfected = false;

  @override
  void initState() {
    super.initState();
  }

  Future<CitizenData> getCitizenData(id, password) =>
      api.getCitizenSummary(id: id, password: password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Citizen'),
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
                labelText: 'Citizen\'s name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              padding: const EdgeInsets.all(20),
              child: DropdownButton(
                value: genderValue,
                onChanged: (String? newValue) {
                  setState(() {
                    genderValue = newValue!;
                  });
                },
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
              )),
          Container(
              padding: const EdgeInsets.all(20),
              child: CheckboxListTile(
                title: const Text("Is the citizen infected?"),
                value: isInfected,
                onChanged: (newValue) {
                  setState(() {
                    isInfected = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              )),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: ElevatedButton(
              child: const Text(
                'Register New Citizen',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              onPressed: () {},
            ),
          ),
        ],
      )),
    );
  }
}
