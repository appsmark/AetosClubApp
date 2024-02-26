import 'package:flutter/material.dart';

import 'data.dart';
import 'sizes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool buttonEnabled = true;
  Team team = Team();
  // Initial Selected Value
  late String dropdownvalue;
  late String dropdownvalueAlternative;
  Sizes sizes = Sizes.instance;
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
    return Scaffold(
        backgroundColor: sizes.colorBackground,
        appBar: AppBar(
          toolbarHeight: sizes.heightToolbar,
          backgroundColor: sizes.colorBackground,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 0.05 * sizes.screenHeight,
              color: sizes.colorTitle,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "INSTELLINGEN",
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: sizes.spacing,
              //      color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " TEAM: ",
                  style: TextStyle(
                      backgroundColor: sizes.colorBackground,
                      color: sizes.colorSelection,
                      fontSize: sizes.sizeFontSelection),
                ),
                DropdownButton(
                  // Initial Value
                  underline: const SizedBox(),
                  dropdownColor: const Color(0xFF00AADE),
                  value: dropdownvalue,
                  autofocus: true,
                  // Down Arrow Icon
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: sizes.colorSelection,
                  ),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                            color: sizes.colorSelection,
                            fontSize: sizes.sizeFontSelection),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      team.set(newValue);
                      dropdownvalue = newValue!;
                      teamInfo.getSchedule(team.currentTeam);
                    });
                  },
                ),
              ],
            ),

/*            
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
*/
          ],
        ));
  }
}
