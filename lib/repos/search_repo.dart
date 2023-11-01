import 'dart:convert';
import 'package:weather_app/data/SearchDataModel.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  static Future<List<SearchDataModel>> fetchSearchData(String cityName) async {
    try {
      final response = await http.get(
        Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
          'name': '$cityName',
          'count': '10',
          'language': 'en',
          'format': 'json',
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.containsKey("results")) {
          final results = data["results"];
          List<SearchDataModel> searchDataModel = results
              .map<SearchDataModel>(
                (resultData) => SearchDataModel.fromJson(resultData),
              )
              .toList();

          print("Length: ${searchDataModel.length}");
          return searchDataModel;
        } else {
          print('Error: "results" key not found in the response');
          return []; // Return an empty list to indicate an issue with the response structure.
        }
      } else {
        print('Error: ${response.statusCode}');
        return []; // Return an empty list to indicate an HTTP error.
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list to indicate a generic error.
    }
  }
}
