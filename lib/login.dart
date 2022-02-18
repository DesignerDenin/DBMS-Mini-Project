import 'dart:ffi';

import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'citizen.dart';
import 'official.dart';

const path = 'librust.so';
late final library = DynamicLibrary.open(path);
late final api = RustImpl(library);

class Login extends StatefulWidget {
  final String userType;
  const Login({Key? key, required this.userType}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String header = "Sign in";
  var headerColor = Colors.black;

  @override
  void initState() {
    super.initState();
  }

  Future<CitizenData> getCitizenData(id, password) =>
      api.getCitizenSummary(id: id, password: password);

  Future<OfficialData> getOfficialData(id, password) =>
      api.getOfficialSummary(id: id, password: password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                header,
                style: TextStyle(fontSize: 20, color: headerColor),
              )),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User ID',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              obscureText: true,
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
              onPressed: () async {
                if (widget.userType == "citizen") {
                  try {
                    var data = await getCitizenData(
                        int.parse(nameController.text),
                        passwordController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Citizen(data: data)));
                  } catch (e) {
                    setState(() {
                      header = "Sign in - incorrect credentials";
                      headerColor = Colors.red;
                    });
                  }
                } else if (widget.userType == "official") {
                  try {
                    var data = await getOfficialData(
                        int.parse(nameController.text),
                        passwordController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Official(data: data, api: api)));
                  } catch (e) {
                    setState(() {
                      header = "Sign in - incorrect credentials";
                      headerColor = Colors.red;
                    });
                  }
                }
              },
              child: widget.userType == "official"
                  ? const Text(
                      'Login as official',
                    )
                  : const Text(
                      'Login as citizen',
                    ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
