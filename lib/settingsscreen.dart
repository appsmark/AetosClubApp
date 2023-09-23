import 'package:flutter/material.dart';
import 'data.dart';
import 'rss.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool buttonEnabled = true;
  Team team = Team();
  // Initial Selected Value
  late String dropdownvalue;
  late String dropdownvalueAlternative;
  TeamInfo teamInfo = TeamInfo();
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    dropdownvalue = team.currentTeam;
    dropdownvalueAlternative = team.alternativeTeam;
    for (int index = 0; index < teamInfo.teamsInfo.length; index++) {
      items.add(teamInfo.teamsInfo[index][0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double spacing = 0.05 * screenHeight;
    return Scaffold(
        backgroundColor: const Color(0xFF731816),
        appBar: AppBar(
          backgroundColor: const Color(0xFF731816),
          leading: const BackButton(
            color: Color(0xFF00AADE),
          ),
          centerTitle: true,
          title: const Text(
            "INSTELLINGEN",
            style: TextStyle(color: Color(0xFF00AADE), fontSize: 35),
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
                  style: TextStyle(color: Color(0xFFF9B234), fontSize: 25),
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
                            //backgroundColor: Color(0xFF731816),
                            color: Color(0xFFF9B234), //Color(0xFF00AADE),
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
                      getRSS(teamInfo.getRanking(team.currentTeam));
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "ALTERNATIEF: ",
                  style: TextStyle(color: Color(0xFFF9B234), fontSize: 25),
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdownvalueAlternative,
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
                            //backgroundColor: Color(0xFF731816),
                            color: Color(0xFFF9B234), //Color(0xFF00AADE),
                            fontSize: 25),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      team.setAlternativeTeam(newValue!);
                      dropdownvalueAlternative = newValue;
//                      getRSS(teamInfo.getRanking(team.currentTeam));
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
