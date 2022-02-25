import 'dart:ffi';

import 'package:dbms/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'citizen.dart';
import 'official.dart';
import 'package:dbms/rust/main.dart';

class Login extends StatefulWidget {
  final RustImpl api;
  final String userType;
  const Login({Key? key, required this.userType, required this.api})
      : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = "";

  @override
  void initState() {
    super.initState();
  }

  Future<CitizenData> getCitizenData(id, password) =>
      widget.api.getCitizenSummary(id: id, password: password);

  Future<OfficialData> getOfficialData(id, password) =>
      widget.api.getOfficialSummary(id: id, password: password);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScroller(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
              "Sign In",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: black,
                fontFamily: "Raleway",
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: nameController,
                style: const TextStyle(
                  fontFamily: "Raleway",
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User ID',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextField(
                obscureText: true,
                style: const TextStyle(
                  fontFamily: "Raleway",
                ),
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Text(
                error,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: "Raleway", fontSize: 14, color: Colors.red),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
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
                      error = "The User ID or Password is incorrect: $e";
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
                                Official(data: data, api: widget.api)));
                  } catch (e) {
                    setState(() {
                      error = "The User ID or Password is incorrect";
                    });
                  }
                }
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: widget.userType == "official"
                    ? const Text(
                        'Login as Official',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18,
                        ),
                      )
                    : const Text(
                        'Login as Citizen',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 18,
                        ),
                      ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
