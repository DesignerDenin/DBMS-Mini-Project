import 'dart:ffi';

import 'package:dbms/global.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'new_citizen.dart';
import 'package:dbms/rust/main.dart';

const path = 'librust.so';
late final library = DynamicLibrary.open(path);
late final api = RustImpl(library);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(title: 'Vaccine Management System'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      body: CustomScroller(
        context: context,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                height: 1.2,
                color: black,
                fontFamily: "Raleway",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Continue as:",
              style: TextStyle(
                fontSize: 18,
                color: black,
                fontFamily: "Raleway",
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Login(userType: "citizen", api: api),
                      ),
                    );
                  },
                  child: loginOptionCard(
                    "assets/health.png",
                    "Citizen",
                  ),
                  style: buttonStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Login(userType: "official", api: api),
                      ),
                    );
                  },
                  child: loginOptionCard(
                    "assets/padlock.png",
                    "Official",
                  ),
                  style: buttonStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCitizen(api: api)),
                    );
                  },
                  child: loginOptionCard(
                    "assets/new.png",
                    "Register Citizen",
                  ),
                  style: buttonStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container loginOptionCard(String asset, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            asset,
            height: 64,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              height: 1.2,
              color: black,
              fontWeight: FontWeight.w500,
              fontFamily: "Raleway",
            ),
          )
        ],
      ),
    );
  }

  ButtonStyle buttonStyle = ButtonStyle(
    overlayColor:
        MaterialStateProperty.all(const Color.fromARGB(255, 197, 224, 250)),
    backgroundColor: MaterialStateProperty.all(grey),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}
