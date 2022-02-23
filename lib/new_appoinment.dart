import 'dart:ffi';

import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAppoinment extends StatefulWidget {
  final RustImpl api;
  const NewAppoinment({Key? key, required this.api}) : super(key: key);

  @override
  State<NewAppoinment> createState() => NewAppoinmentState();
}

class NewAppoinmentState extends State<NewAppoinment> {
  TextEditingController citizenidController = TextEditingController();

  String selectedCenter = "De";
  late List<String> items;

  @override
  void initState() {
    super.initState();
    getVaxCenters().then((value) {
      setState(() {
        items = value;
        selectedCenter = items[0];
      });
    });
  }

  Future<List<String>> getVaxCenters() => widget.api.getVaxCenters();

  Future<void> addAppoinment(citizenId, centerId) =>
      widget.api.addAppoinment(citizenId: citizenId, centerId: centerId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Appoinment'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: DropdownButton<String>(
              value: selectedCenter.toString(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCenter = newValue!;
                });
              },
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: citizenidController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Citizen\'s ID',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: ElevatedButton(
              child: const Text(
                'Register New Appoinment',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
                try {
                  await addAppoinment(int.parse(citizenidController.text),
                      int.parse(selectedCenter.split(":")[0]));

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text(
                              "You have successfully registered a new Appoinment."),
                        );
                      });
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(
                              "Could not successfully create the new center: $e"),
                        );
                      });
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
