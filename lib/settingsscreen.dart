import 'package:flutter/material.dart';
import 'data.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  Data data = Data();
  bool buttonEnabled = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = 0.8 * screenWidth;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF731816),
        centerTitle: true,
        title: const Text(
          "SELECTEER TEAM",
          style: TextStyle(color: Color(0xFF00AADE), fontSize: 25),
        ),
      ),
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
    );
  }
}
