class RssClean {
  String clean(String stream) {
    String result = stream;
    result = result.replaceAll(" Nationale competitie", "");
    result = result.replaceAll(" Regio Oost", "");
    result = result.replaceAll("Eerste ", "1e ");
    result = result.replaceAll("tweede ", "2e ");
    result = result.replaceAll("Tweede ", "2e ");
    result = result.replaceAll("Twedde ", "2e ");
    result = result.replaceAll(" 1e helft", "");
    result = result.replaceAll(" 2e helft", "");
    result = result.replaceAll("De Laar", "Sporthal De Laar");
    result = result.replaceAll("Valkenhuizen", "Sporthal Valkenhuizen");
    result = result.replaceAll(" Apeldoorn ", " ");
    result = result.replaceAll("'05 ", "");
    result = result.replaceAll("Bielderman Koetsier/", "");
    result = result.replaceAll("Bultman-Hartholt ", "");
    result = result.replaceAll(
        "Burgemeester Cees van der Knaapweg", "Burgemeester v.d. Knaapweg");
    result = result.replaceAll("Engeltherm ", "");
    result = result.replaceAll("Eurosped ", "");
    result = result.replaceAll("Ikvolleybal.nl/", "");
    result = result.replaceAll("Jumbo Van Andel-", "");
    result = result.replaceAll("Rebo Woningmakelaars ", "");
    result = result.replaceAll("Rensa Family ", "");
    result = result.replaceAll("Skopein ", "");
    result = result.replaceAll("Sportclub ", "");
    result = result.replaceAll("Steenderen ", "");
    result = result.replaceAll("'Topklimaat in Volleybal' ", "");
    result = result.replaceAll("VoCASA/Pegasus ", "VOCASA ");
    result = result.replaceAll("Volleybalvereniging ", "");
    result = result.replaceAll("Volleybal Club Varsseveld ", "");
    result = result.replaceAll("Voorsterslag/", "");
    result = result.replaceAll("Fortis in Unum", "Fortis");
    result = result.replaceAll("Weghorst Makelaardij ", "");
    result = result.replaceAll("(IJsselmuiden) ", "");
    result = result.replaceAll("Athena Business Support ", "");
    result = result.replaceAll("Lammerink Installatiegroep/", "");
    result = result.replaceAll("Komeet ", "");
    result = result.replaceAll("Nieuwleusen ", "");
    result = result.replaceAll("/Vollverijs", "");
    result = result.replaceAll("Seesing Flex | ", "");
    result = result.replaceAll("D.V.C.", "DVC");
    result = result.replaceAll("Zitvolley ", "");
    result = result.replaceAll("Zitvolleybal ", "");
    result = result.replaceAll("Rageroom Venlo ", "");
    result = result.replaceAll("HS ", "H");
    result = result.replaceAll(" DS ", " D");
    result = result.replaceAll("JA ", "JA");
    result = result.replaceAll("JB ", "JB");
    result = result.replaceAll("JC ", "JC");
    result = result.replaceAll("MA ", "MA");
    result = result.replaceAll("MB ", "MB");
    result = result.replaceAll("MC ", "MC");
    result = result.replaceAll("MD ", "MD");
    result = result.replaceAll("XZ ", "XZ");
    result = result.replaceAll(" Arnh/Wag", " Arnhem/Wageningen\n");
    result = result.replaceAll(" march", " maart");
    result = result.replaceAll(" may", " mei");

    return result;
  }
}
