import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool buttonEnabled = true;
  // Initial Selected Value
  String dropdownvalue = team.get();

  @override
  void initState() {
    super.initState();
  }

  // List of items in our dropdown menu
  // var items = data.getAllTeams();
  //var items = data.listOfTeams;

  var items = [
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'D7',
    'D8',
    'D9',
    'D10',
    'D11',
    'H1',
    'H2',
    'H3',
    'H4',
    'H5',
    'H6',
    'H7',
    'H8',
    'H9',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF731816),
          centerTitle: true,
          title: const Text(
            "SELECTEER TEAM",
            style: TextStyle(color: Color(0xFF00AADE), fontSize: 25),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                // Initial Value
                value: dropdownvalue,
                autofocus: true,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(
                          color: Color(0xFF00AADE), fontSize: 25),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    team.set(newValue);
                    dropdownvalue = newValue!;
                    //                   var newT = context.read<Team>();
                    //                 newT.set(newValue);
                  });
                },
              ),
            ],
          ),
        ));
  }
}
