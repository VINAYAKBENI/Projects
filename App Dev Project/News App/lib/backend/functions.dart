import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/searchbar.dart';
import '../utils/key.dart';

Future<List> fetchnews(String category) async {
  final response = await http.get(
    Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&pageSize=100&apiKey=${Key.key}&q=${MySearchBar.searchcontroller.text}'),
  );
  Map result=jsonDecode(response.body);
  //print('fetched');
  return( result['articles']);
}
