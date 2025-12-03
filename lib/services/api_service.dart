import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

Future<List<Quote>> getQuotes({int numberOfQuotes = 5}) async {
  List<Future<List<Quote>>> requests = [];

  for (int i = 0; i < numberOfQuotes; i++) {
    requests.add(_fetchFromApi());
  }
  final results = await Future.wait(requests);
  return results.expand((element) => element).toList();
}

Future<List<Quote>> _fetchFromApi() async {
  const url = 'https://api.api-ninjas.com/v1/quotes';
  const apiKey = 'DOp1U6TOWo0RYmjqczs/nw==qAug3rxykcbiZZ45'; 

  final response = await http.get(
    Uri.parse(url),
    headers: {'X-Api-Key': apiKey},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    return (data as List)
        .map((item) => Quote.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load quotes: ${response.statusCode}');
  }
}