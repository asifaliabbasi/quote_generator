import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qoute_generator/Apis/Api.dart';
import 'QuotesModel.dart';

class fetchQuotes{
  List<QuotesApi> quoteList = [];

  Future<void>processData()async{
    String apiUrl = 'https://api.api-ninjas.com/v1/quotes';
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Api-Key': apiKey},
    );
    var jsonString = jsonDecode(response.body);
    for (var quote in jsonString) {
      quoteList.add(QuotesApi.fromJson(quote));
    }

  }
}