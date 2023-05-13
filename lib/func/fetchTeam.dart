import 'dart:convert';
import'package:http/http.dart' as http;
Future<List<dynamic>> fetchNbaTeams() async {
  final response = await http.get(
      Uri.parse('https://free-nba.p.rapidapi.com/teams'),
      headers: {
        'X-RapidAPI-Key': 'd9a90fe7edmsha38a206f698e96cp11203djsn6cb7b5339d6e',
        'X-RapidAPI-Host': 'free-nba.p.rapidapi.com'
      });

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    return map['data'];
  } else {
    throw Exception('Failed to fetch data from API');
  }
}