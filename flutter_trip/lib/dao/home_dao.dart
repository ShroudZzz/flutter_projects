import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var url = Uri.parse(HOME_URL);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home json');
    }
  }
}