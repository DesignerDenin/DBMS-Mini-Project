import 'package:dbms/rust/main.dart';
import 'package:flutter/material.dart';

class NewVaxCenter extends StatefulWidget {
  final RustImpl api;
  const NewVaxCenter({Key? key, required this.api}) : super(key: key);

  @override
  State<NewVaxCenter> createState() => NewVaxCenterState();
}

class NewVaxCenterState extends State<NewVaxCenter> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<ID> addVaxCenter(name, location) =>
      widget.api.addVaccinationCenter(name: name, location: location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register VaxCenter'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vaccination Center\'s name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vaccination Center\'s location',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: ElevatedButton(
              child: const Text(
                'Register New VaxCenter',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
                try {
                  var id = await addVaxCenter(
                    nameController.text,
                    locationController.text,
                  );

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              "You have successfully registered a new Vaccination Center."),
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
