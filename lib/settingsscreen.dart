import 'package:flutter/material.dart';
import 'data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool buttonEnabled = true;
  Team team = Team();
  // Initial Selected Value
  late String dropdownvalue; // = team.get();
  TeamInfo teamInfo = TeamInfo();
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    dropdownvalue = team.get();
    for (int index = 0; index < teamInfo.teamsInfo.length; index++) {
      items.add(teamInfo.teamsInfo[index][0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double spacing = 0.05 * screenHeight;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF731816),
          centerTitle: true,
          title: const Text(
            "INSTELLINGEN",
            style: TextStyle(color: Color(0xFF00AADE), fontSize: 25),
          ),
        ),
        body: Column(
          children: [
            Container(height: spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "TEAM: ",
                  style: TextStyle(color: Color(0xFF00AADE), fontSize: 25),
                ),
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
                            // backgroundColor: Color(0xFF731816),
                            color: Color(0xFF00AADE),
                            fontSize: 25),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      team.set(newValue);
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
