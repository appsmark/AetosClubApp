var RSS = "https://api.nevobo.nl/export/team/CNH8Q1U/heren/11/programma.rss";
var RSS2 = "https://api.nevobo.nl/export/poule/regio-oost/H3H/stand.rss";

//$(document).ready(function () {
    var entries = [];
    var selectedEntry = "";
//    $("#id_page_splash_team").ready(function () {
//        $.get(RSS, {}, function (res1, code1) {
//            var xml = $(res1);
//            var items = xml.find("item");
//            var play_date = items[0].children[0].textContent;
//            document.getElementById("id_play_date").innerText = play_date.replace(": ", "\n");
//        });
//    });

//});

function rssSetFeedFor(id) {
    if (id[0] === 'H') {
        path = "heren/";
    } else {
        path = "dames/";
    }
    path += id.substr(1, 2);
    RSS = "https://api.nevobo.nl/export/team/CNH8Q1U/" + path + "/programma.rss";
    $.get(RSS, {}, function (res1, code1) {
        var xml = $(res1);
        var items = xml.find("item");
        var play_date = items[0].children[0].textContent;
        var location = items[0].children[3].textContent;
        document.getElementById("id_play_date").innerText = play_date.replace(": ", "\n\n").replace("-", "\ntegen\n");
        document.getElementById("id_play_location").innerText = location.substr(location.search("Speel"), 100).replace(/,/g,"\n").replace("Speellocatie:","");
    });
}

function rssGetFeedFor(id) {
    if (id[0] === 'H') {
        path = "heren/";
    } else {
        path = "dames/";
    }
    path += id.substr(1, 2);
    RSS = "https://api.nevobo.nl/export/team/CNH8Q1U/" + path + "/programma.rss";
    $.get(RSS, {}, function (res1, code1) {
        var xml = $(res1);
        var items = xml.find("item");
        var play_date = items[0].children[0].textContent;
        var location = items[0].children[3].textContent;
        document.getElementById("id_play_date").innerText = play_date.replace(": ", "\n\n").replace("-", "\ntegen\n");
        document.getElementById("id_play_location").innerText = location.substr(location.search("Speel"), 100).replace(/,/g, "\n").replace("Speellocatie:", "");
    });
}
