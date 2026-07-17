class Ads {
  static final Ads instance = Ads._internal();
  List ads = [
    ["omejoop", "omejoopstour.nl"],
    ["errea", "errea.nl"],
    ["flitsendbeeld", "flitsendbeeld.nl"],
    ["buitenga-campers", "buitenga-campers.nl"],
    ["hendriks", "hendriks-assurantien.nl"],
    ["huisman", "huismansport.nl"],
    ["academie", "volleybaltrainersacademie.nl"],
    ["fruitkraam", "defruitkraam.nl"],
    ["verandago", "verandago.nl"],
    ["plauti", "plauti.com"],
    ["bestliving", "bestliving.nl"],
    ["apps-mark", "apps-mark.nl"],
  ];
  int index = 0;

  String getLogo() {
    return "${ads[index][0]}.png";
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
