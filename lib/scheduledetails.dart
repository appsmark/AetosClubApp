import 'package:flutter/material.dart';

import 'constants.dart';
import 'players.dart';
import 'rss_clean.dart';
import 'sizes.dart';

class ScheduleDetails {
  Players players = Players.instance;
  Sizes sizes = Sizes.instance;

  Future<void> scheduleDetails(BuildContext context, int index,
      List listOfItems, String counter, String referee, String dutyTeam) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constants().colorRanking,
          title: Text(
            "DETAILS WEDSTRIJD",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constants().colorTitle,
                fontSize: sizes.tablet
                    ? 0.015 * sizes.screenHeight
                    : 0.025 * sizes.screenHeight,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            SizedBox(
              height: 0.6 * sizes.screenHeight,
              width: 0.8 * sizes.screenWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        listOfItems[index]['date'],
                        style: TextStyle(
                            color: Constants().colorScheduleDetails,
                            fontSize: 0.9 * sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        listOfItems[index]['time'] == "0:00"
                            ? ""
                            : listOfItems[index]['time'],
                        style: TextStyle(
                            color: Constants().colorScheduleDetails,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    listOfItems[index]['game'],
                    style: TextStyle(
                        color: Constants().colorScheduleDetails,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  Visibility(
                    visible: counter != "",
                    child: SizedBox(
                      height: 0.01 * sizes.screenHeight,
                    ),
                  ),
                  Visibility(
                    visible: counter != "",
                    child: Text(
                      "Teller: $counter",
                      style: TextStyle(
                          color: /*counterOwnTeam
                              ? Constants().colorTitle
                              : */
                              Constants().colorScheduleDetails,
                          fontSize: sizes.sizeFontSchedule,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: referee != "",
                    child: Text(
                      "Scheidsrechter: $referee",
                      style: TextStyle(
                          color: Constants().colorScheduleDetails,
                          fontSize: sizes.sizeFontSchedule,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: dutyTeam != "",
                    child: Text(
                      "Zaalwacht: $dutyTeam",
                      style: TextStyle(
                          color: Constants().colorScheduleDetails,
                          fontSize: sizes.sizeFontSchedule,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 0.01 * sizes.screenHeight,
                  ),
                  Text(
                    RssClean().clean(listOfItems[index]['hall']),
                    style: TextStyle(
                        color: Constants().colorScheduleDetails,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    RssClean().clean(listOfItems[index]['street']),
                    style: TextStyle(
                        color: Constants().colorScheduleDetails,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    listOfItems[index]['postal'],
                    style: TextStyle(
                        color: Constants().colorScheduleDetails,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  separator(),
                  for (int indexPlayer = 0;
                      indexPlayer < players.data.length;
                      indexPlayer++)
                    Text(
                      players.data[indexPlayer]['name'],
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: Constants().colorTitle,
    );
  }
}
