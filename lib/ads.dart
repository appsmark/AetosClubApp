class Ads {
  static final Ads instance = Ads._internal();
  List ads = [
    ["omejoop", "omejoopstour.nl"],
    ["errea", "errea.nl"],
    ["flitsendbeeld", "flitsendbeeld.nl"],
    ["buitenga", "buitenga-campers.nl"],
    ["hendriks", "hendriks-assurantien.nl"],
    ["huisman", "huismansport.nl"],
    ["academie", "volleybaltrainersacademie.nl"],
    ["fruitkraam", "defruitkraam.nl"],
    ["verandago", "verandago.nl"],
    ["plauti", "plauti.com"],
    ["bestliving", "bestliving.nl"],
    ["rijssenbeek", "rijssenbeek.nl"],
    ["flink", "goflink.com", "nl-NL"],
    ["publiqbelasting", "publiqbelastingadviseurs.nl"],
    ["kicken", "kicken-om.nl"],
    ["jeroenkleinbussink", "jeroenkleinbussink.nl"],
    ["vinoos", "vinoos.nl"],
    ["snackattack", "snackattack-arnhem.nl"],
    ["specsavers", "specsavers.nl"],
    ["focuskliniek", "focuskliniekstjansdal.nl"],
    ["bordbusters", "bordbusters.nl"],
    ["apps-mark", "apps-mark.nl", "indexNL.html"],
  ];
  int index = 0;

  String getLogo() {
    return "${ads[index][0]}.png";
  }

  String getPath() {
    if (ads[index].length > 2) {
      return ads[index][2];
    }
    return "";
  }

  String getWebsite() {
    return ads[index][1];
  }

  void next() {
    index++;
    if (index >= ads.length) {
      index = 0;
    }
  }

  Ads._internal();
}
