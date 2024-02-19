class RssClean {
  String clean(String stream) {
    String result = stream;
    result = result.replaceAll("Tweede ", "2e ");
    result = result.replaceAll("Twedde ", "2e ");
    result = result.replaceAll("2e helft ", "");
    result = result.replaceAll("Sportclub ", "");
    result = result.replaceAll("Rensa Family ", "");
    result = result.replaceAll("Rebo Woningmakelaars ", "");
    result = result.replaceAll(" Apeldoorn ", " ");
    result = result.replaceAll("Ikvolleybal.nl/", "");
    result = result.replaceAll("'05 ", "");
    result = result.replaceAll("Bultman-Hartholt ", "");
    result = result.replaceAll("Bielderman Koetsier/", "");
    result = result.replaceAll("Volleybalvereniging ", "");
    result = result.replaceAll("Skopein ", "");
    result = result.replaceAll("Engeltherm ", "");
    result = result.replaceAll("Eurosped ", "");
    result = result.replaceAll("Voorsterslag/", "");
    result = result.replaceAll("Weghorst Makelaardij ", "");
    return result;
  }
}
