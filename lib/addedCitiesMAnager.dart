import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/SearchDataModel.dart';

class AddedCitiesManager {
  List<SearchDataModel> addedCities = [];

  // Singleton pattern
  AddedCitiesManager._privateConstructor();
  static final AddedCitiesManager instance = AddedCitiesManager._privateConstructor();

  // Load addedCities from shared preferences
  Future<void> loadAddedCities() async {
    final preferences = await SharedPreferences.getInstance();
    final addedCitiesJson = preferences.getString('addedCities');
    if (addedCitiesJson != null) {
      addedCities = (jsonDecode(addedCitiesJson) as List)
          .map((item) => SearchDataModel.fromJson(item))
          .toList();
    }
  }

  // Save addedCities to shared preferences
  Future<void> saveAddedCities() async {
    final preferences = await SharedPreferences.getInstance();
    final addedCitiesJson = jsonEncode(addedCities);
    await preferences.setString('addedCities', addedCitiesJson);
  }
}
