import 'dart:convert';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/SearchDataModel.dart';
import 'package:weather_app/data/SearchDataModel.dart';
import 'package:weather_app/repos/search_repo.dart';
import 'package:weather_app/data/SearchDataModel.dart';

part 'search_event.dart';
part 'search_state.dart';
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<SearchDataModel> addedCities = [];
  SearchBloc() : super(SearchInitial()) {
    _loadAddedCities();
    on<IntialSearchEvent>(intialSearchEvent);
    on<AddCityEvent>(addCityEvent);
    on<RemoveCityEvent>(removeCityEvent);
   
  }

  Future<void> intialSearchEvent(
      IntialSearchEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchLoadingState());

      List<SearchDataModel> searchData = await SearchRepo.fetchSearchData(event.userQuery);

      emit(SearchSuccesfullState(searchdata: searchData));
      print('Success');
    } catch (e) {
      // Handle errors here and emit an error state if needed
      print("error:" + e.toString());
    }
  }
  Future<void> addCityEvent(AddCityEvent event, Emitter<SearchState> emit) async {
    try {
      // Add the city to the list of added cities
      addedCities.add(event.city);
      _saveAddedCities();

      print('City added successfully');
      
      emit(CityAddedState(city: event.city)); // Emit a new state to notify the UI
    } catch (e) {
      // Handle errors here and emit an error state if needed
      print("error:" + e.toString());
    }
  }
   Future<void> _loadAddedCities() async {
    final preferences = await SharedPreferences.getInstance();
    final addedCitiesJson = preferences.getString('addedCities');
    if (addedCitiesJson != null) {
      addedCities = (jsonDecode(addedCitiesJson) as List)
          .map((item) => SearchDataModel.fromJson(item))
          .toList();
    }
  }

  Future<void> _saveAddedCities() async {
    final preferences = await SharedPreferences.getInstance();
    final addedCitiesJson = jsonEncode(addedCities);
    await preferences.setString('addedCities', addedCitiesJson);
  }
  Future<void> removeCityEvent(RemoveCityEvent event, Emitter<SearchState> emit) async {
    try {
      // Remove the city from the list of added cities
      addedCities.remove(event.city);

      // Save the updated list to shared preferences
      _saveAddedCities();

      emit(CityRemovedState(city: event.city)); // Emit a new state to notify the UI
    } catch (e) {
      // Handle errors here and emit an error state if needed
      print("error:" + e.toString());
    }
  }
}






