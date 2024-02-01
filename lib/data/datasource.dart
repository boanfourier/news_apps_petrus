import 'package:http/http.dart' as http;
import 'package:news_apps_petrus/model/news.dart';

class DataSource {
  Future<String?> getNews() async {
    try {
      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=keyword&apiKey=4b397c0b925c48649a61b00c6ab69622&pageSize=10'));
      return response.body;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
