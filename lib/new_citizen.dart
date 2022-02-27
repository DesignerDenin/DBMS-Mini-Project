import 'package:dbms/global.dart';
import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewCitizen extends StatefulWidget {
  final RustImpl api;
  const NewCitizen({Key? key, required this.api}) : super(key: key);

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
  var textFieldStyle = const TextStyle(
    fontFamily: "Raleway",
  );

  @override
  void initState() {
    super.initState();
  }

  Future<ID> addCitizen(name, password, age, gender) => widget.api
      .addCitizen(name: name, password: password, age: age, gender: gender);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScroller(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => {Navigator.of(context).pop()},
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 40,
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                "Register Citizen",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: black,
                  fontFamily: "Raleway",
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: nameController,
                style: textFieldStyle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Citizen\'s name',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ageController,
                style: textFieldStyle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                style: textFieldStyle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
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
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    try {
                      var id = await addCitizen(
                          nameController.text,
                          passwordController.text,
                          int.parse(ageController.text),
                          genderValue == "Male" ? "M" : "F");

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  "You have successfully registered a new citizen."),
                              content: Text("ID: ${id.id}"),
                            );
                          });
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content: Text(
                                  "Could not successfully create entry: $e"),
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
