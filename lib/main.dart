import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(title: 'Vax tracker - DBMS project'),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Login(userType: "official")));
                },
                child: const Text(
                  'Login as official',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
            const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 20)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Login(userType: "citizen")));
                },
                child: const Text(
                  'Login as citizen',
                  style: TextStyle(color: Colors.white),
                ),
                // ignore: prefer_const_constructors
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                )),
          ],
        ),
      ),
    );
  }
}
