import 'package:flutter/material.dart';
import 'data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
//  _SettingsScreenState createState() => _SettingsScreenState();
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool buttonEnabled = true;
  // Initial Selected Value

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
    String dropdownvalue = data.currentTeam;
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
                    dropdownvalue = newValue!;
                    data.currentTeam = newValue;
                  });
                },
              ),
            ],
          ),

/*
      body: ListView.builder(
          itemCount: data.listOfTeams.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                debugPrint('Tapped on item #$index');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(buttonWidth, 90),
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: Colors.black, width: 4),
                          backgroundColor: const Color(0xFFF9B234)),
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            data.listOfTeams[index].toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
*/
        ));
  }
}
