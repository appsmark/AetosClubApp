import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

// Get the Medium RSSFeed data
Future<RssFeed?> getRSS() async {
  try {
    final client = http.Client();
    final response =
        await client.get("https://medium.com/feed/@TJgrapes" as Uri);
//        "https://api.nevobo.nl/export/poule/regio-oost/DPD/stand.rss" as Uri);
    return RssFeed.parse(response.body);
  } catch (e) {
    print(e);
  }
  return null;
}
